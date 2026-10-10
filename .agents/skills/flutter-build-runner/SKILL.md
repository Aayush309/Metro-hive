---
name: flutter-build-runner
description: Managing Dart code generation workflows, build.yaml performance optimization, and resolving builder conflicts using build_runner in Flutter.
---

# Flutter Build Runner Skill Guide (Latest 2.4.14+)

## Overview
`build_runner` is the standard code generation runner for Dart and Flutter projects. It drives generators for Riverpod (`riverpod_generator`), Drift (`drift_dev`), Freezed (`freezed`), JSON Serialization (`json_serializable`), and Go Router (`go_router_builder`).

---

## 1. Primary CLI Commands

### One-shot Generation (Recommended for builds/CI)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### File Watcher (Recommended during active development)
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Clean Cache & Artifacts
```bash
dart run build_runner clean
```

---

## 2. Optimizing with `build.yaml`

Create a `build.yaml` in the project root to restrict which files builders scan, dramatically accelerating generation times:

```yaml
targets:
  $default:
    builders:
      riverpod_generator:
        options:
          # Custom riverpod generator options
        generate_for:
          - lib/**
      drift_dev:
        options:
          override_hash_and_equals_in_result_sets: true
          compact_query_results: true
          store_date_time_values_as_text: true
        generate_for:
          - lib/**
```

---

## 3. Supported Package Integrations (Latest Versions)

| Generator Package | Latest Version | Triggers | Generated Files |
|-------------------|----------------|----------|-----------------|
| `riverpod_generator` | `^4.0.9` | `@riverpod` annotations | `*.g.dart` |
| `drift_dev` | `^2.24.0` | `@DriftDatabase`, `Table` definitions | `*.g.dart` |
| `freezed` | `^2.5.7` | `@freezed` annotations | `*.freezed.dart` |
| `json_serializable` | `^6.8.0` | `@JsonSerializable()` | `*.g.dart` |
| `go_router_builder` | `^2.7.0` | `@TypedGoRoute` annotations | `*.g.dart` |

---

## 4. Troubleshooting Build Runner Issues

### Issue 1: Conflicting Outputs
**Symptom**: `Build script failed with: ... Outputs already exist on disk`.
**Solution**:
Run command with flag:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Issue 2: Outdated Cache / Stale Symbols
**Symptom**: Generated class properties do not match model changes despite rerunning build.
**Solution**:
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Issue 3: Missing `part 'filename.g.dart';`
**Symptom**: Code generator skips annotated classes.
**Solution**: Ensure the source Dart file contains exact relative part statement matching the file name:
```dart
// file: user_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
```

---

## 5. Best Practices & Rules

1. **Always use `--delete-conflicting-outputs`**: Prevents manual deletion of conflicting generated files during development.
2. **Never edit `*.g.dart` or `*.freezed.dart` directly**: Generated files are overwritten on every build pass.
3. **Commit generated files to Git**: Unless team policy strictly dictates otherwise, committing `.g.dart` files allows instant workspace builds without requiring full code generation runs upfront.
4. **Use `generate_for` filters in `build.yaml`**: Speeds up build times by preventing builders from scanning unrelated UI code.
