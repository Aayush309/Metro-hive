/// Riverpod providers for manual data loading and locale management.
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/fault.dart';
import 'data/fault_matcher.dart';
import '../../common/constants.dart';

part 'manual_providers.g.dart';

// ---------------------------------------------------------------------------
// Manual (fault list) provider — loaded once from bundled JSON asset.
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
Future<List<Fault>> faultList(Ref ref) async {
  final jsonStr = await rootBundle.loadString('assets/manual.json');
  final map = json.decode(jsonStr) as Map<String, dynamic>;
  final faultsJson = map['faults'] as List<dynamic>;
  return faultsJson
      .map((f) => Fault.fromJson(f as Map<String, dynamic>))
      .toList();
}

/// Faults filtered by category.
@riverpod
Future<List<Fault>> faultsByCategory(Ref ref, FaultCategory category) async {
  final all = await ref.watch(faultListProvider.future);
  return all.where((f) => f.category == category.jsonKey).toList();
}

// ---------------------------------------------------------------------------
// FaultMatcher provider — injectable, defaults to keyword matcher.
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
FaultMatcher faultMatcher(Ref ref) {
  return KeywordFaultMatcher();
}

// ---------------------------------------------------------------------------
// Locale preference provider — persisted to shared_preferences.
// ---------------------------------------------------------------------------

const _localeKey = 'app_locale';

@Riverpod(keepAlive: true)
class LocalePreference extends _$LocalePreference {
  @override
  String build() {
    // Load asynchronously and update state once ready.
    _load();
    return 'en'; // default
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_localeKey);
    if (stored != null && stored != state) {
      state = stored;
    }
  }

  Future<void> toggle() async {
    final next = state == 'en' ? 'gu' : 'en';
    state = next;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, next);
  }
}
