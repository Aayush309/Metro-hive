---
name: flutter-drift
description: Guidelines, database schema definitions, reactive queries, migrations, DAOs, and path_provider integrations using Drift SQLite ORM in Flutter.
---

# Flutter Drift Skill Guide (Latest 2.24+)

## Overview
Drift is a reactive, type-safe persistence and SQLite ORM library for Dart & Flutter. It generates Dart data classes and type-safe query builders from Dart tables or raw SQL.

---

## 1. Project Setup & Dependencies (Latest Versions)
Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  drift: ^2.24.0
  sqlite3_flutter_libs: ^0.5.28
  path_provider: ^2.1.6
  path: ^1.9.1
  flutter_riverpod: ^3.4.3
  riverpod_annotation: ^4.0.7

dev_dependencies:
  drift_dev: ^2.24.0
  build_runner: ^2.4.14
  riverpod_generator: ^4.0.9
```

---

## 2. Table Definition

Create schema files in `lib/src/features/data/tables/`:

```dart
import 'package:drift/drift.dart';

@DataClassName('TodoEntry')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get content => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 3. Database Initialization with `path_provider`

Define the database class in `lib/src/features/data/database/app_database.dart`:

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Schema migrations step by step
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
```

---

## 4. Reactive Queries & Data Manipulation

```dart
extension TodoQueries on AppDatabase {
  // Reactive stream updates automatically whenever table changes
  Stream<List<TodoEntry>> watchAllTodos() {
    return (select(todos)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  Future<List<TodoEntry>> getAllTodos() {
    return select(todos).get();
  }

  Future<int> addTodo(TodosCompanion entry) {
    return into(todos).insert(entry);
  }

  Future<bool> updateTodo(TodoEntry entry) {
    return update(todos).replace(entry);
  }

  Future<void> toggleTodoStatus(int id, bool isCompleted) async {
    await (update(todos)..where((t) => t.id.equals(id))).write(
      TodosCompanion(completed: Value(isCompleted)),
    );
  }

  Future<int> deleteTodo(int id) {
    return (delete(todos)..where((t) => t.id.equals(id))).go();
  }
}
```

---

## 5. Integrating Drift with Riverpod 3.x

Expose database singletons and reactive streams via Riverpod 3.x providers:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';

part 'database_provider.g.dart';

// Singleton AppDatabase Provider in Riverpod 3.x
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

// Reactive Stream Provider for UI
@riverpod
Stream<List<TodoEntry>> todosStream(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllTodos();
}
```

---

## 6. Code Generation Command

Run build runner to generate `.g.dart` file:
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 7. Best Practices & Rules

1. **Use `LazyDatabase`**: Always initialize SQLite files lazily using `getApplicationDocumentsDirectory()` to ensure storage path availability on mobile/desktop platforms.
2. **Use Background Connections**: Use `NativeDatabase.createInBackground(file)` to run database operations off the main UI thread.
3. **Immutability with Companions**: When inserting or partially updating fields, use generated `Companion` classes (`TodosCompanion(title: Value('Task'))`) to specify optional or defaulted values.
4. **Dispose Database Instance**: Always register `ref.onDispose(() => db.close())` on Riverpod database providers to avoid database file locks.
5. **Testing**: For unit tests, use `NativeDatabase.memory()` to test database logic entirely in memory without touching disk storage.
