/// Drift database for Tunnel Tech — log entries and step progress.
library;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ---------------------------------------------------------------------------
// Tables
// ---------------------------------------------------------------------------

/// A logged fault entry (shift log).
class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get faultId => text()();
  TextColumn get assetLabel => text().withDefault(const Constant(''))();
  TextColumn get status => text()(); // 'fixed' | 'not_fixed'
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
}

/// Per-fault step completion progress.
class StepProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get faultId => text()();

  /// Comma-separated indices of completed steps, e.g. "0,2,3".
  TextColumn get completedSteps => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {faultId},
      ];
}

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(tables: [LogEntries, StepProgress])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// For testing.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }

  // ---- Log Entries ----

  Future<int> insertLog(LogEntriesCompanion entry) {
    return into(logEntries).insert(entry);
  }

  /// All log entries for today, newest first.
  Stream<List<LogEntry>> watchTodayLogs() {
    final startOfDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return (select(logEntries)
          ..where((t) => t.timestamp.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .watch();
  }

  /// Count of unsynced log entries.
  Stream<int> watchPendingCount() {
    final query = selectOnly(logEntries)
      ..addColumns([logEntries.id.count()])
      ..where(logEntries.synced.equals(false));
    return query.map((row) => row.read(logEntries.id.count()) ?? 0).watchSingle();
  }

  /// Count of times the same faultId + assetLabel was logged this week.
  Future<int> repeatFaultCount(String faultId, String assetLabel) async {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final query = select(logEntries)
      ..where((t) =>
          t.faultId.equals(faultId) &
          t.assetLabel.equals(assetLabel) &
          t.timestamp.isBiggerOrEqualValue(weekAgo));
    final results = await query.get();
    return results.length;
  }

  /// Mark all pending items as synced.
  Future<int> markAllSynced() {
    return (update(logEntries)..where((t) => t.synced.equals(false)))
        .write(const LogEntriesCompanion(synced: Value(true)));
  }

  // ---- Step Progress ----

  /// Get or create step progress for a fault.
  Future<StepProgressData> getOrCreateProgress(String faultId) async {
    final existing = await (select(stepProgress)
          ..where((t) => t.faultId.equals(faultId)))
        .getSingleOrNull();
    if (existing != null) return existing;

    final id = await into(stepProgress).insert(
      StepProgressCompanion.insert(faultId: faultId),
    );
    return StepProgressData(
      id: id,
      faultId: faultId,
      completedSteps: '',
      updatedAt: DateTime.now(),
    );
  }

  /// Update completed steps for a fault.
  Future<void> updateProgress(String faultId, Set<int> completed) async {
    final csv = completed.toList()..sort();
    await (update(stepProgress)..where((t) => t.faultId.equals(faultId)))
        .write(StepProgressCompanion(
      completedSteps: Value(csv.join(',')),
      updatedAt: Value(DateTime.now()),
    ));
  }
}

// ---------------------------------------------------------------------------
// Connection helper
// ---------------------------------------------------------------------------

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tunnel_tech.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
