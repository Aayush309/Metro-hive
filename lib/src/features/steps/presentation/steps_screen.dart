/// Steps screen — safety banner, step checkboxes, progress bar, actions.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_line/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/language_toggle.dart';
import '../../../common/widgets/sync_chip.dart';
import '../../manual/manual_providers.dart';
import '../../manual/domain/fault.dart';
import '../../log/data/log_providers.dart';
import '../../log/data/app_database.dart';

class StepsScreen extends ConsumerStatefulWidget {
  const StepsScreen({required this.faultId, super.key});
  final String faultId;

  @override
  ConsumerState<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends ConsumerState<StepsScreen> {
  final _assetController = TextEditingController();
  int? _repeatCount;
  bool _showEscalate = false;

  @override
  void dispose() {
    _assetController.dispose();
    super.dispose();
  }

  Fault? _findFault() {
    final faults = ref.read(faultListProvider).value;
    if (faults == null) return null;
    try {
      return faults.firstWhere((f) => f.id == widget.faultId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _logFault(String status) async {
    final db = ref.read(appDatabaseProvider);
    await db.insertLog(LogEntriesCompanion(
      faultId: Value(widget.faultId),
      assetLabel: Value(_assetController.text.trim()),
      status: Value(status),
    ));

    final count = await db.repeatFaultCount(
      widget.faultId,
      _assetController.text.trim(),
    );
    if (count >= 2 && mounted) {
      setState(() => _repeatCount = count);
    }

    if (mounted) {
      if (status == 'not_fixed') {
        setState(() => _showEscalate = true);
      } else {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localePreferenceProvider);
    final theme = Theme.of(context);
    final fault = _findFault();

    if (fault == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.stepsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final progressAsync = ref.watch(
      stepProgressProvider(widget.faultId),
    );
    final completed = progressAsync.value ?? <int>{};
    final steps = fault.steps(locale);
    final totalSteps = steps.length;
    final completedCount = completed.length;
    final progress = totalSteps > 0 ? completedCount / totalSteps : 0.0;
    final isFullyCompleted = completedCount == totalSteps && totalSteps > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stepsTitle),
        actions: const [
          SyncChip(),
          SizedBox(width: 4),
          LanguageToggle(),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Safety banner FIRST ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFB91C1C), Color(0xFF7F1D1D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEF4444), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.safetyWarning.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        fault.safety(locale),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ── Fault Header Card ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        fault.id.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      fault.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  fault.title(locale),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _assetController,
                  decoration: InputDecoration(
                    hintText: l10n.assetLabelHint,
                    prefixIcon: const Icon(Icons.qr_code_outlined, size: 20),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ── Progress Bar Card ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PROGRESS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      l10n.stepProgress(completedCount, totalSteps),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isFullyCompleted ? Colors.green : theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: theme.colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isFullyCompleted ? const Color(0xFF10B981) : theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ── Steps Title ──
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'TROUBLESHOOTING STEPS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 0.8,
              ),
            ),
          ),

          // ── Step Checkbox Cards ──
          ...List.generate(totalSteps, (i) {
            final isChecked = completed.contains(i);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: isChecked
                      ? theme.colorScheme.primary.withValues(alpha: 0.08)
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isChecked
                        ? theme.colorScheme.primary.withValues(alpha: 0.5)
                        : theme.colorScheme.outline.withValues(alpha: 0.4),
                  ),
                ),
                child: CheckboxListTile(
                  value: isChecked,
                  onChanged: (_) {
                    ref
                        .read(stepProgressProvider(widget.faultId).notifier)
                        .toggleStep(i);
                  },
                  secondary: CircleAvatar(
                    radius: 14,
                    backgroundColor: isChecked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surface,
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isChecked ? Colors.black : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  title: Text(
                    steps[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isChecked ? FontWeight.w500 : FontWeight.w600,
                      decoration: isChecked ? TextDecoration.lineThrough : null,
                      color: isChecked
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                ),
              ),
            );
          }),

          const SizedBox(height: 14),

          // ── Repeat Fault Warning Banner ──
          if (_repeatCount != null && _repeatCount! >= 2)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.history_rounded, color: Colors.amber, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.repeatFault(_repeatCount!),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // ── Escalate Box ──
          if (_showEscalate) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF7F1D1D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEF4444), width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.escalateMessage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse(kControlRoomNumber);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    icon: const Icon(Icons.phone_in_talk_rounded),
                    label: Text(l10n.escalateCall),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: Text(
                      l10n.homeTitle,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Bottom Action Buttons ──
          if (!_showEscalate) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _logFault('fixed'),
                    icon: const Icon(Icons.check_circle_rounded),
                    label: Text(l10n.markFixed),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _logFault('not_fixed'),
                    icon: const Icon(Icons.highlight_off_rounded),
                    label: Text(l10n.markNotFixed),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
