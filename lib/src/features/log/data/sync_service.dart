/// Stub sync service — marks pending items as synced.
///
/// This is CLEARLY FAKE and meant to be replaced with a real API client.
/// In production, this would POST log entries to a backend and only mark
/// them synced on a 200 response.
library;

import 'app_database.dart';

class SyncService {
  SyncService(this._db);
  final AppDatabase _db;

  /// Fake sync: simply marks all pending log entries as synced.
  ///
  /// TODO(production): Replace with real HTTP POST to fleet management API.
  /// Example:
  /// ```
  /// final pending = await _db.getPendingEntries();
  /// for (final entry in pending) {
  ///   final response = await http.post(apiUrl, body: entry.toJson());
  ///   if (response.statusCode == 200) {
  ///     await _db.markSynced(entry.id);
  ///   }
  /// }
  /// ```
  Future<void> syncPending() async {
    // Simulate a small network delay.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await _db.markAllSynced();
  }
}
