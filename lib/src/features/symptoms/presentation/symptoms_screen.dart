/// Symptoms screen — list of faults for a category, with search.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_line/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/language_toggle.dart';
import '../../../common/widgets/sync_chip.dart';
import '../../manual/manual_providers.dart';
import '../../manual/domain/fault.dart';

class SymptomsScreen extends ConsumerStatefulWidget {
  const SymptomsScreen({required this.category, super.key});
  final FaultCategory category;

  @override
  ConsumerState<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends ConsumerState<SymptomsScreen> {
  final _searchController = TextEditingController();
  List<Fault> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    final allFaults = ref.read(faultListProvider).value ?? [];
    final matcher = ref.read(faultMatcherProvider);
    setState(() {
      _searchResults = matcher.match(query, allFaults);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localePreferenceProvider);
    final theme = Theme.of(context);
    final isOther = widget.category == FaultCategory.other;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.symptomsTitle),
        actions: const [
          SyncChip(),
          SizedBox(width: 4),
          LanguageToggle(),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Category Banner Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _iconForCategory(widget.category),
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _labelForCategory(widget.category, l10n),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: isOther
                ? _buildOtherSearch(context, l10n, locale, theme)
                : _buildFaultList(context, l10n, locale, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildFaultList(
    BuildContext context,
    AppLocalizations l10n,
    String locale,
    ThemeData theme,
  ) {
    final faultsAsync = ref.watch(
      faultsByCategoryProvider(widget.category),
    );

    return switch (faultsAsync) {
      AsyncData(:final value) => value.isEmpty
          ? Center(
              child: Text(
                l10n.tapToStart,
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: value.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final fault = value[index];
                return _FaultTile(fault: fault, locale: locale);
              },
            ),
      AsyncError(:final error) => Center(
          child: Text(
            'Error loading symptoms: $error',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildOtherSearch(
    BuildContext context,
    AppLocalizations l10n,
    String locale,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearch,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: l10n.otherSearchHint,
              prefixIcon: Icon(Icons.search_rounded, color: theme.colorScheme.primary),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.cancel_rounded),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_searchResults.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.otherSearchResults,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        Expanded(
          child: _searchResults.isEmpty && _searchController.text.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded, size: 48, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(height: 12),
                      Text(
                        l10n.noMatchesFound,
                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchResults.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final fault = _searchResults[index];
                    return _FaultTile(fault: fault, locale: locale);
                  },
                ),
        ),
      ],
    );
  }

  static IconData _iconForCategory(FaultCategory cat) {
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

  static String _labelForCategory(FaultCategory cat, AppLocalizations l10n) {
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

class _FaultTile extends StatelessWidget {
  const _FaultTile({required this.fault, required this.locale});
  final Fault fault;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final currentPath = GoRouterState.of(context).uri.toString();
            context.push('$currentPath/steps/${fault.id}');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              fault.id.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${fault.stepCount} Steps',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fault.title(locale),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
