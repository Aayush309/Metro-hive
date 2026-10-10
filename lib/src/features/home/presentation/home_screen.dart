/// Home screen — category grid with hero banner, sync chip, and language toggle.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_line/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/sync_chip.dart';
import '../../../common/widgets/language_toggle.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.subway_outlined,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              l10n.homeTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          SyncChip(),
          SizedBox(width: 6),
          LanguageToggle(),
          SizedBox(width: 12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.surfaceContainerHighest,
                      theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            'TECH FIELD MANUAL',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '100% Offline',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.homeSubtitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = FaultCategory.values[index];
                  return _CategoryCard(category: cat);
                },
                childCount: FaultCategory.values.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.18,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/shift-log'),
        icon: const Icon(Icons.assignment_outlined),
        label: Text(l10n.shiftLogTitle),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});
  final FaultCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final color = _accentColorFor(category, theme);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/symptoms/${category.name}'),
          borderRadius: BorderRadius.circular(18),
          splashColor: color.withValues(alpha: 0.2),
          highlightColor: color.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _iconFor(category),
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _labelFor(category, l10n),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Color _accentColorFor(FaultCategory cat, ThemeData theme) {
    return switch (cat) {
      FaultCategory.doors => const Color(0xFF38BDF8),
      FaultCategory.ticketGates => const Color(0xFF818CF8),
      FaultCategory.liftsEscalators => const Color(0xFFF472B6),
      FaultCategory.signalling => const Color(0xFFFBBF24),
      FaultCategory.power => const Color(0xFF34D399),
      FaultCategory.networkComms => const Color(0xFFA78BFA),
      FaultCategory.hvac => const Color(0xFF2DD4BF),
      FaultCategory.other => const Color(0xFF9CA3AF),
    };
  }

  static IconData _iconFor(FaultCategory cat) {
    return switch (cat) {
      FaultCategory.doors => Icons.door_sliding_outlined,
      FaultCategory.ticketGates => Icons.qr_code_scanner_outlined,
      FaultCategory.liftsEscalators => Icons.elevator_outlined,
      FaultCategory.signalling => Icons.traffic_outlined,
      FaultCategory.power => Icons.bolt_outlined,
      FaultCategory.networkComms => Icons.cell_tower_outlined,
      FaultCategory.hvac => Icons.ac_unit_outlined,
      FaultCategory.other => Icons.build_outlined,
    };
  }

  static String _labelFor(FaultCategory cat, AppLocalizations l10n) {
    return switch (cat) {
      FaultCategory.doors => l10n.categoryDoors,
      FaultCategory.ticketGates => l10n.categoryTicketGates,
      FaultCategory.liftsEscalators => l10n.categoryLiftsEscalators,
      FaultCategory.signalling => l10n.categorySignalling,
      FaultCategory.power => l10n.categoryPower,
      FaultCategory.networkComms => l10n.categoryNetworkComms,
      FaultCategory.hvac => l10n.categoryHvac,
      FaultCategory.other => l10n.categoryOther,
    };
  }
}
