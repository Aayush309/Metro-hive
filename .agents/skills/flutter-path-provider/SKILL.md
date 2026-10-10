---
name: flutter-path-provider
description: Cross-platform file storage access, application documents directories, cache directories, and path manipulation in Flutter using path_provider and path.
---

# Flutter Path Provider Skill Guide (Latest 2.1.5+)

## Overview
`path_provider` is the standard Flutter plugin for accessing host platform storage locations (Android, iOS, macOS, Windows, Linux). `path` provides cross-platform path string utilities.

---

## 1. Project Dependencies Setup (Latest Versions)
Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  path_provider: ^2.1.6
  path: ^1.9.1
  flutter_riverpod: ^3.4.3
  riverpod_annotation: ^4.0.7
```

---

## 2. Platform Directory Matrix

| Method | Android | iOS | Desktop | Web | Purpose |
|--------|---------|-----|---------|-----|---------|
| `getApplicationDocumentsDirectory()` | App data dir | Documents folder | User Documents | Unsupported (throws/fallback) | Persistent user-generated data (DBs, documents) |
| `getTemporaryDirectory()` | Cache dir | `tmp/` dir | System Temp folder | Unsupported | Temporary files safe to clear anytime |
| `getApplicationSupportDirectory()` | App support | Application Support | App Support | Unsupported | App internal configuration/files |
| `getExternalStorageDirectory()` | External storage | `null` | `null` | Unsupported | Android external files |

---

## 3. Recommended Code Patterns

### Safe Path Concatenation with `path`
Always use `p.join` from `package:path/path.dart` instead of string interpolation (`$dir/$file`) to support cross-platform path separators (`/` vs `\`).

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileStorageService {
  Future<File> getFileInDocuments(String filename) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final filePath = p.join(docsDir.path, filename);
    return File(filePath);
  }

  Future<File> getCacheFile(String filename) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = p.join(tempDir.path, filename);
    return File(filePath);
  }

  Future<void> clearTempCache() async {
    final tempDir = await getTemporaryDirectory();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  }
}
```

---

## 4. Riverpod 3.x Service Provider Example

Expose persistent storage services via Riverpod 3.x providers:

```dart
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'storage_provider.g.dart';

@riverpod
Future<Directory> applicationDocumentsDir(Ref ref) async {
  return getApplicationDocumentsDirectory();
}

@riverpod
Future<File> logFile(Ref ref) async {
  final docsDir = await ref.watch(applicationDocumentsDirProvider.future);
  final logPath = p.join(docsDir.path, 'app_logs', 'app.log');
  final file = File(logPath);
  await file.parent.create(recursive: true);
  return file;
}
```

---

## 5. Integration with Drift & Local Databases

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

LazyDatabase openDatabaseConnection(String dbName) {
  return LazyDatabase(() async {
    final docsFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(docsFolder.path, '$dbName.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
```

---

## 6. Best Practices & Rules

1. **Never Hardcode Absolute Paths**: Absolute paths differ across OS versions, device models, and user profiles. Always resolve paths dynamically via `path_provider`.
2. **Always Use `p.join(...)`**: Avoid manually concatenating slashes. `p.join` prevents malformed double slashes and handles Windows backslashes (`\`).
3. **Use Temporary Directory for Caches**: Store downloaded images, temporary exports, or intermediate binary blobs in `getTemporaryDirectory()` so OS disk cleaner utilities can free space when required.
4. **Ensure Parent Directory Exists**: Call `await file.parent.create(recursive: true)` before creating or writing to nested files.
5. **Handle Web Platform Gracefully**: On Web platforms, physical disk storage does not exist. Check `kIsWeb` before making `path_provider` calls or use web-compatible persistence (IndexedDB / shared_preferences).
