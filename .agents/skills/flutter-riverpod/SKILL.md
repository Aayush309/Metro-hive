---
name: flutter-riverpod
description: Best practices, code generation patterns, and state management conventions for Flutter apps using Riverpod 3.x with riverpod_annotation and riverpod_generator.
---

# Flutter Riverpod 3.x Skill Guide

## Overview
Riverpod 3.x is the latest major release of the reactive, compile-safe state management framework for Dart & Flutter. Riverpod 3 introduces unified `Ref` types, simplified code generation, enhanced lifecycle management, and seamless async state handling.

---

## 1. Project Dependencies Setup (Riverpod 3.x)
Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.4.3
  riverpod_annotation: ^4.0.7

dev_dependencies:
  riverpod_generator: ^4.0.9
  riverpod_lint: ^3.1.9
  custom_lint: ^0.8.1
  build_runner: ^2.4.14
```

---

## 2. Core Concepts & Provider Types in Riverpod 3.x

### Unified `Ref` & Annotations
In Riverpod 3.x, code generator uses a unified `Ref` object, simplifying signature parameters across functional and class providers.

| State Type | Return Type | Annotation | Use Case |
|------------|-------------|------------|----------|
| Synchronous Functional | `T` | `@riverpod` | Pure values, computed getters, service instances |
| Asynchronous Functional | `Future<T>` | `@riverpod` | One-shot async data fetching |
| Synchronous Class | `Notifier<T>` | `@riverpod` | Mutable sync state updated via controller methods |
| Asynchronous Class | `AsyncNotifier<T>` | `@riverpod` | Mutable async state updated via controller methods |

---

## 3. Code Generation Patterns (Riverpod 3.x)

### A. Synchronous Functional Provider
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

@riverpod
String appTitle(Ref ref) {
  return 'Metro Line App';
}
```

### B. Async Functional Provider (Data Fetching)
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<User> fetchUser(Ref ref, {required String userId}) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserById(userId);
}
```

### C. Class-based AsyncNotifier (Riverpod 3.x State Mutation)
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:metro_line/src/features/todo/domain/todo.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  Future<List<Todo>> build() async {
    final repository = ref.watch(todoRepositoryProvider);
    return repository.fetchTodos();
  }

  Future<void> addTodo(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.addTodo(title);
      return repository.fetchTodos();
    });
  }

  Future<void> toggleTodo(String id) async {
    final previousState = state.valueOrNull ?? [];
    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.toggleTodo(id);
      return previousState.map((todo) {
        return todo.id == id ? todo.copyWith(isCompleted: !todo.isCompleted) : todo;
      }).toList();
    });
  }
}
```

---

## 4. Consuming Providers in UI (Riverpod 3.x)

### Root Setup: `ProviderScope`
Wrap `App` with `ProviderScope` in `main.dart`:

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### Pattern Matching on `AsyncValue` (Dart 3 + Riverpod 3.x)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoListNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: switch (todosAsync) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final todo = value[index];
              return ListTile(
                title: Text(todo.title),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => ref
                      .read(todoListNotifierProvider.notifier)
                      .toggleTodo(todo.id),
                ),
              );
            },
          ),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
```

### Reacting to Side Effects with `ref.listen`
```dart
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      loginControllerProvider,
      (previous, next) {
        switch (next) {
          case AsyncError(:final error):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: $error')),
            );
          case AsyncData():
            // Navigate on success
            break;
          default:
            break;
        }
      },
    );

    return Scaffold(/* UI */);
  }
}
```

---

## 5. Best Practices & Rules in Riverpod 3.x

1. **Use Unified `Ref` Type**: Riverpod 3 simplified generated reference parameters to `Ref ref` for functional providers.
2. **Never Call `ref.read` Inside `build()`**:
   - Use `ref.watch` to subscribe to state changes in `build()`.
   - Use `ref.read` strictly in user callbacks (`onPressed`, `onChanged`).
3. **Use `AsyncValue.guard`**: Safely execute mutations and auto-capture exceptions to set `AsyncError`.
4. **Use `@Riverpod(keepAlive: true)` for Global Singletons**: Prevent auto-dispose on core services, database connections, and repositories.
5. **Always Run Code Generation**:
   `dart run build_runner watch --delete-conflicting-outputs`
