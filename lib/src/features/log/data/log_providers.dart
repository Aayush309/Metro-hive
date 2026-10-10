/// Riverpod providers for database, sync, and connectivity.
library;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';
import 'sync_service.dart';

part 'log_providers.g.dart';

// ---------------------------------------------------------------------------
// Database singleton
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

// ---------------------------------------------------------------------------
// Today's log entries (reactive manual provider to avoid codegen analyzer part issue with Drift data classes)
final todayLogsProvider = StreamProvider<List<LogEntry>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchTodayLogs();
});

// ---------------------------------------------------------------------------
// Pending sync count (reactive)
// ---------------------------------------------------------------------------

@riverpod
Stream<int> pendingCount(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchPendingCount();
}

// ---------------------------------------------------------------------------
// Connectivity state
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
class ConnectivityNotifier extends _$ConnectivityNotifier {
  StreamSubscription<List<ConnectivityResult>>? _sub;

  @override
  bool build() {
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      state = online;
      if (online) {
        // Trigger fake sync when connectivity returns.
        ref.read(syncServiceProvider).syncPending();
      }
    });
    ref.onDispose(() => _sub?.cancel());
    return false; // assume offline until we know
  }
}

// ---------------------------------------------------------------------------
// Sync service
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
SyncService syncService(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncService(db);
}

// ---------------------------------------------------------------------------
// Step-progress controller
// ---------------------------------------------------------------------------

@riverpod
class StepProgressNotifier extends _$StepProgressNotifier {
  @override
  Future<Set<int>> build(String faultId) async {
    final db = ref.watch(appDatabaseProvider);
    final progress = await db.getOrCreateProgress(faultId);
    return _parseCsv(progress.completedSteps);
  }

  Future<void> toggleStep(int index) async {
    final current = state.value ?? {};
    final next = Set<int>.from(current);
    if (next.contains(index)) {
      next.remove(index);
    } else {
      next.add(index);
    }
    state = AsyncData(next);

    final db = ref.read(appDatabaseProvider);
    await db.updateProgress(
      faultId,
      next,
    );
  }

  Set<int> _parseCsv(String csv) {
    if (csv.isEmpty) return {};
    return csv.split(',').map(int.parse).toSet();
  }
}
