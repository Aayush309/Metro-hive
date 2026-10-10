/// Tunnel Tech app shell — MaterialApp.router with l10n and theme.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing/app_router.dart';
import 'common/theme.dart';
import 'features/manual/manual_providers.dart';

class TunnelTechApp extends ConsumerWidget {
  const TunnelTechApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final locale = ref.watch(localePreferenceProvider);

    return MaterialApp.router(
      title: 'Tunnel Tech',
      debugShowCheckedModeBanner: false,
      theme: tunnelTechTheme(),
      locale: Locale(locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
