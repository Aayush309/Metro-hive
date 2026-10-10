/// Persistent sync status chip — "Offline · N pending" / "Online · synced".
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_line/l10n/app_localizations.dart';

import '../../features/log/data/log_providers.dart';

class SyncChip extends ConsumerWidget {
  const SyncChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(connectivityProvider);
    final pendingAsync = ref.watch(pendingCountProvider);
    final l10n = AppLocalizations.of(context);

    final pendingCount = pendingAsync.value ?? 0;

    final label = isOnline
        ? l10n.onlineChip
        : l10n.offlineChip(pendingCount);

    final icon = isOnline
        ? Icons.cloud_done_rounded
        : Icons.cloud_off_rounded;

    final color = isOnline
        ? const Color(0xFF10B981)
        : const Color(0xFFF59E0B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
