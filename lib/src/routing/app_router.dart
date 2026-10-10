/// GoRouter configuration for Tunnel Tech.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/symptoms/presentation/symptoms_screen.dart';
import '../features/steps/presentation/steps_screen.dart';
import '../features/log/presentation/shift_log_screen.dart';
import '../common/constants.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'symptoms/:category',
            builder: (context, state) {
              final categoryStr = state.pathParameters['category']!;
              final category = FaultCategory.values.firstWhere(
                (c) => c.name == categoryStr,
                orElse: () => FaultCategory.other,
              );
              return SymptomsScreen(category: category);
            },
            routes: [
              GoRoute(
                path: 'steps/:faultId',
                builder: (context, state) {
                  final faultId = state.pathParameters['faultId']!;
                  return StepsScreen(faultId: faultId);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'shift-log',
            builder: (context, state) => const ShiftLogScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
}
