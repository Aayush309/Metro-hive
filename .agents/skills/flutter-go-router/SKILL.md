---
name: flutter-go-router
description: Declarative routing, nested navigation with StatefulShellRoute, route guards, redirect logic, and Riverpod integration using go_router in Flutter.
---

# Flutter Go Router Skill Guide (Latest 14.8+)

## Overview
`go_router` is the official Flutter declarative routing package. It simplifies route navigation, nested shell navigation (e.g. bottom navigation bars with state preservation), path/query parameter handling, and authentication state guards.

---

## 1. Project Setup (Latest Versions)
Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^14.8.0
  flutter_riverpod: ^3.4.3
  riverpod_annotation: ^4.0.7
```

---

## 2. Basic Router Setup with Riverpod 3.x Integration

Create router configuration in `lib/src/routing/app_router.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'details/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final filter = state.uri.queryParameters['filter'];
              return DetailsScreen(id: id, filter: filter);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
}
```

---

## 3. Nested Shell Routing (Bottom Navigation Bar)

Use `StatefulShellRoute.indexedStack` to preserve navigation state across bottom navigation tabs:

```dart
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

final StatefulShellRoute bottomNavShellRoute = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeKey,
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _shellNavigatorSettingsKey,
      routes: [
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
```

---

## 4. Navigation Operations

| Action | API | Description |
|--------|-----|-------------|
| Go to route | `context.go('/home')` | Replaces target route on the navigation stack |
| Push route | `context.push('/details/42')` | Pushes route on top of active navigator stack |
| Pop route | `context.pop()` | Pops top route from active navigator stack |
| Replace route | `context.replace('/login')` | Replaces current top route without adding back stack entry |
| Named Route | `context.goNamed('details', pathParameters: {'id': '42'})` | Navigates using unique route name |

---

## 5. Wiring `GoRouter` in `MaterialApp.router` (Riverpod 3.x)

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Metro Line',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: router,
    );
  }
}
```

---

## 6. Best Practices & Rules

1. **Prefer `context.go` over `context.push`**: Use `context.go` for declarative, URL-aligned page transitions. Use `context.push` for modal/ephemeral sub-flows.
2. **Rebind Router Ref with `ref.watch`**: Pass auth state to `GoRouter` and watch it in `goRouterProvider` so route redirects recalculate automatically when login state changes in Riverpod 3.x.
3. **Use `StatefulShellRoute` for Bottom Nav**: Always use `StatefulShellRoute.indexedStack` instead of `ShellRoute` when maintaining state on tab switches.
4. **Clean Parameter Extraction**: Safely inspect `state.pathParameters` and `state.uri.queryParameters` rather than parsing strings manually.
