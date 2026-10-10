import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metro_line/src/app.dart';
import 'package:metro_line/src/features/log/data/app_database.dart';
import 'package:metro_line/src/features/log/data/log_providers.dart';
import 'package:metro_line/src/features/manual/manual_providers.dart';
import 'package:metro_line/src/features/manual/data/fault_matcher.dart';
import 'package:metro_line/src/features/manual/domain/fault.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('TunnelTechApp smoke test', (WidgetTester tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          connectivityProvider.overrideWith(() => _TestConnectivityNotifier()),
          localePreferenceProvider.overrideWith(() => _TestLocalePreference()),
        ],
        child: const TunnelTechApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(TunnelTechApp), findsOneWidget);

    // Dispose widget tree and flush any pending stream cancellation timers
    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
    await db.close();
  });

  test('KeywordFaultMatcher matches queries correctly', () {
    final matcher = KeywordFaultMatcher();
    const fault = Fault(
      id: 'f1',
      category: 'doors',
      titleEn: 'Door obstructed',
      titleGu: 'દરવાજો અવરોધિત',
      safetyEn: 'Power off',
      safetyGu: 'પાવર બંધ કરો',
      stepsEn: ['Step 1'],
      stepsGu: ['પગલું 1'],
      keywords: ['door', 'stuck'],
    );

    final results = matcher.match('stuck', [fault]);
    expect(results.length, equals(1));
    expect(results.first.id, equals('f1'));

    final noMatch = matcher.match('escalator', [fault]);
    expect(noMatch, isEmpty);
  });
}

class _TestConnectivityNotifier extends ConnectivityNotifier {
  @override
  bool build() => false;
}

class _TestLocalePreference extends LocalePreference {
  @override
  String build() => 'en';
}
