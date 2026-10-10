// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _faultIdMeta = const VerificationMeta(
    'faultId',
  );
  @override
  late final GeneratedColumn<String> faultId = GeneratedColumn<String>(
    'fault_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetLabelMeta = const VerificationMeta(
    'assetLabel',
  );
  @override
  late final GeneratedColumn<String> assetLabel = GeneratedColumn<String>(
    'asset_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    faultId,
    assetLabel,
    status,
    timestamp,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fault_id')) {
      context.handle(
        _faultIdMeta,
        faultId.isAcceptableOrUnknown(data['fault_id']!, _faultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_faultIdMeta);
    }
    if (data.containsKey('asset_label')) {
      context.handle(
        _assetLabelMeta,
        assetLabel.isAcceptableOrUnknown(data['asset_label']!, _assetLabelMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      faultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fault_id'],
      )!,
      assetLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_label'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }
}

class LogEntry extends DataClass implements Insertable<LogEntry> {
  final int id;
  final String faultId;
  final String assetLabel;
  final String status;
  final DateTime timestamp;
  final bool synced;
  const LogEntry({
    required this.id,
    required this.faultId,
    required this.assetLabel,
    required this.status,
    required this.timestamp,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fault_id'] = Variable<String>(faultId);
    map['asset_label'] = Variable<String>(assetLabel);
    map['status'] = Variable<String>(status);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      faultId: Value(faultId),
      assetLabel: Value(assetLabel),
      status: Value(status),
      timestamp: Value(timestamp),
      synced: Value(synced),
    );
  }

  factory LogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntry(
      id: serializer.fromJson<int>(json['id']),
      faultId: serializer.fromJson<String>(json['faultId']),
      assetLabel: serializer.fromJson<String>(json['assetLabel']),
      status: serializer.fromJson<String>(json['status']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'faultId': serializer.toJson<String>(faultId),
      'assetLabel': serializer.toJson<String>(assetLabel),
      'status': serializer.toJson<String>(status),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  LogEntry copyWith({
    int? id,
    String? faultId,
    String? assetLabel,
    String? status,
    DateTime? timestamp,
    bool? synced,
  }) => LogEntry(
    id: id ?? this.id,
    faultId: faultId ?? this.faultId,
    assetLabel: assetLabel ?? this.assetLabel,
    status: status ?? this.status,
    timestamp: timestamp ?? this.timestamp,
    synced: synced ?? this.synced,
  );
  LogEntry copyWithCompanion(LogEntriesCompanion data) {
    return LogEntry(
      id: data.id.present ? data.id.value : this.id,
      faultId: data.faultId.present ? data.faultId.value : this.faultId,
      assetLabel: data.assetLabel.present
          ? data.assetLabel.value
          : this.assetLabel,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntry(')
          ..write('id: $id, ')
          ..write('faultId: $faultId, ')
          ..write('assetLabel: $assetLabel, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, faultId, assetLabel, status, timestamp, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntry &&
          other.id == this.id &&
          other.faultId == this.faultId &&
          other.assetLabel == this.assetLabel &&
          other.status == this.status &&
          other.timestamp == this.timestamp &&
          other.synced == this.synced);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntry> {
  final Value<int> id;
  final Value<String> faultId;
  final Value<String> assetLabel;
  final Value<String> status;
  final Value<DateTime> timestamp;
  final Value<bool> synced;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.faultId = const Value.absent(),
    this.assetLabel = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.synced = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String faultId,
    this.assetLabel = const Value.absent(),
    required String status,
    this.timestamp = const Value.absent(),
    this.synced = const Value.absent(),
  }) : faultId = Value(faultId),
       status = Value(status);
  static Insertable<LogEntry> custom({
    Expression<int>? id,
    Expression<String>? faultId,
    Expression<String>? assetLabel,
    Expression<String>? status,
    Expression<DateTime>? timestamp,
    Expression<bool>? synced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (faultId != null) 'fault_id': faultId,
      if (assetLabel != null) 'asset_label': assetLabel,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
      if (synced != null) 'synced': synced,
    });
  }

  LogEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? faultId,
    Value<String>? assetLabel,
    Value<String>? status,
    Value<DateTime>? timestamp,
    Value<bool>? synced,
  }) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      faultId: faultId ?? this.faultId,
      assetLabel: assetLabel ?? this.assetLabel,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (faultId.present) {
      map['fault_id'] = Variable<String>(faultId.value);
    }
    if (assetLabel.present) {
      map['asset_label'] = Variable<String>(assetLabel.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('faultId: $faultId, ')
          ..write('assetLabel: $assetLabel, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }
}

class $StepProgressTable extends StepProgress
    with TableInfo<$StepProgressTable, StepProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _faultIdMeta = const VerificationMeta(
    'faultId',
  );
  @override
  late final GeneratedColumn<String> faultId = GeneratedColumn<String>(
    'fault_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedStepsMeta = const VerificationMeta(
    'completedSteps',
  );
  @override
  late final GeneratedColumn<String> completedSteps = GeneratedColumn<String>(
    'completed_steps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    faultId,
    completedSteps,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fault_id')) {
      context.handle(
        _faultIdMeta,
        faultId.isAcceptableOrUnknown(data['fault_id']!, _faultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_faultIdMeta);
    }
    if (data.containsKey('completed_steps')) {
      context.handle(
        _completedStepsMeta,
        completedSteps.isAcceptableOrUnknown(
          data['completed_steps']!,
          _completedStepsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {faultId},
  ];
  @override
  StepProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      faultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fault_id'],
      )!,
      completedSteps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_steps'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StepProgressTable createAlias(String alias) {
    return $StepProgressTable(attachedDatabase, alias);
  }
}

class StepProgressData extends DataClass
    implements Insertable<StepProgressData> {
  final int id;
  final String faultId;

  /// Comma-separated indices of completed steps, e.g. "0,2,3".
  final String completedSteps;
  final DateTime updatedAt;
  const StepProgressData({
    required this.id,
    required this.faultId,
    required this.completedSteps,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fault_id'] = Variable<String>(faultId);
    map['completed_steps'] = Variable<String>(completedSteps);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StepProgressCompanion toCompanion(bool nullToAbsent) {
    return StepProgressCompanion(
      id: Value(id),
      faultId: Value(faultId),
      completedSteps: Value(completedSteps),
      updatedAt: Value(updatedAt),
    );
  }

  factory StepProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepProgressData(
      id: serializer.fromJson<int>(json['id']),
      faultId: serializer.fromJson<String>(json['faultId']),
      completedSteps: serializer.fromJson<String>(json['completedSteps']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'faultId': serializer.toJson<String>(faultId),
      'completedSteps': serializer.toJson<String>(completedSteps),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StepProgressData copyWith({
    int? id,
    String? faultId,
    String? completedSteps,
    DateTime? updatedAt,
  }) => StepProgressData(
    id: id ?? this.id,
    faultId: faultId ?? this.faultId,
    completedSteps: completedSteps ?? this.completedSteps,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StepProgressData copyWithCompanion(StepProgressCompanion data) {
    return StepProgressData(
      id: data.id.present ? data.id.value : this.id,
      faultId: data.faultId.present ? data.faultId.value : this.faultId,
      completedSteps: data.completedSteps.present
          ? data.completedSteps.value
          : this.completedSteps,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepProgressData(')
          ..write('id: $id, ')
          ..write('faultId: $faultId, ')
          ..write('completedSteps: $completedSteps, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, faultId, completedSteps, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepProgressData &&
          other.id == this.id &&
          other.faultId == this.faultId &&
          other.completedSteps == this.completedSteps &&
          other.updatedAt == this.updatedAt);
}

class StepProgressCompanion extends UpdateCompanion<StepProgressData> {
  final Value<int> id;
  final Value<String> faultId;
  final Value<String> completedSteps;
  final Value<DateTime> updatedAt;
  const StepProgressCompanion({
    this.id = const Value.absent(),
    this.faultId = const Value.absent(),
    this.completedSteps = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StepProgressCompanion.insert({
    this.id = const Value.absent(),
    required String faultId,
    this.completedSteps = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : faultId = Value(faultId);
  static Insertable<StepProgressData> custom({
    Expression<int>? id,
    Expression<String>? faultId,
    Expression<String>? completedSteps,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (faultId != null) 'fault_id': faultId,
      if (completedSteps != null) 'completed_steps': completedSteps,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StepProgressCompanion copyWith({
    Value<int>? id,
    Value<String>? faultId,
    Value<String>? completedSteps,
    Value<DateTime>? updatedAt,
  }) {
    return StepProgressCompanion(
      id: id ?? this.id,
      faultId: faultId ?? this.faultId,
      completedSteps: completedSteps ?? this.completedSteps,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (faultId.present) {
      map['fault_id'] = Variable<String>(faultId.value);
    }
    if (completedSteps.present) {
      map['completed_steps'] = Variable<String>(completedSteps.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepProgressCompanion(')
          ..write('id: $id, ')
          ..write('faultId: $faultId, ')
          ..write('completedSteps: $completedSteps, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  late final $StepProgressTable stepProgress = $StepProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    logEntries,
    stepProgress,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$LogEntriesTableCreateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      required String faultId,
      Value<String> assetLabel,
      required String status,
      Value<DateTime> timestamp,
      Value<bool> synced,
    });
typedef $$LogEntriesTableUpdateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      Value<String> faultId,
      Value<String> assetLabel,
      Value<String> status,
      Value<DateTime> timestamp,
      Value<bool> synced,
    });

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faultId => $composableBuilder(
    column: $table.faultId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetLabel => $composableBuilder(
    column: $table.assetLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faultId => $composableBuilder(
    column: $table.faultId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetLabel => $composableBuilder(
    column: $table.assetLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get faultId =>
      $composableBuilder(column: $table.faultId, builder: (column) => column);

  GeneratedColumn<String> get assetLabel => $composableBuilder(
    column: $table.assetLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$LogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTable,
          LogEntry,
          $$LogEntriesTableFilterComposer,
          $$LogEntriesTableOrderingComposer,
          $$LogEntriesTableAnnotationComposer,
          $$LogEntriesTableCreateCompanionBuilder,
          $$LogEntriesTableUpdateCompanionBuilder,
          (LogEntry, BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry>),
          LogEntry,
          PrefetchHooks Function()
        > {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> faultId = const Value.absent(),
                Value<String> assetLabel = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<bool> synced = const Value.absent(),
              }) => LogEntriesCompanion(
                id: id,
                faultId: faultId,
                assetLabel: assetLabel,
                status: status,
                timestamp: timestamp,
                synced: synced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String faultId,
                Value<String> assetLabel = const Value.absent(),
                required String status,
                Value<DateTime> timestamp = const Value.absent(),
                Value<bool> synced = const Value.absent(),
              }) => LogEntriesCompanion.insert(
                id: id,
                faultId: faultId,
                assetLabel: assetLabel,
                status: status,
                timestamp: timestamp,
                synced: synced,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogEntriesTable, LogEntry>(table),
                  BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTable,
      LogEntry,
      $$LogEntriesTableFilterComposer,
      $$LogEntriesTableOrderingComposer,
      $$LogEntriesTableAnnotationComposer,
      $$LogEntriesTableCreateCompanionBuilder,
      $$LogEntriesTableUpdateCompanionBuilder,
      (LogEntry, BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry>),
      LogEntry,
      PrefetchHooks Function()
    >;
typedef $$StepProgressTableCreateCompanionBuilder =
    StepProgressCompanion Function({
      Value<int> id,
      required String faultId,
      Value<String> completedSteps,
      Value<DateTime> updatedAt,
    });
typedef $$StepProgressTableUpdateCompanionBuilder =
    StepProgressCompanion Function({
      Value<int> id,
      Value<String> faultId,
      Value<String> completedSteps,
      Value<DateTime> updatedAt,
    });

class $$StepProgressTableFilterComposer
    extends Composer<_$AppDatabase, $StepProgressTable> {
  $$StepProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faultId => $composableBuilder(
    column: $table.faultId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StepProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $StepProgressTable> {
  $$StepProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faultId => $composableBuilder(
    column: $table.faultId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StepProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepProgressTable> {
  $$StepProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get faultId =>
      $composableBuilder(column: $table.faultId, builder: (column) => column);

  GeneratedColumn<String> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StepProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StepProgressTable,
          StepProgressData,
          $$StepProgressTableFilterComposer,
          $$StepProgressTableOrderingComposer,
          $$StepProgressTableAnnotationComposer,
          $$StepProgressTableCreateCompanionBuilder,
          $$StepProgressTableUpdateCompanionBuilder,
          (
            StepProgressData,
            BaseReferences<_$AppDatabase, $StepProgressTable, StepProgressData>,
          ),
          StepProgressData,
          PrefetchHooks Function()
        > {
  $$StepProgressTableTableManager(_$AppDatabase db, $StepProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> faultId = const Value.absent(),
                Value<String> completedSteps = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StepProgressCompanion(
                id: id,
                faultId: faultId,
                completedSteps: completedSteps,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String faultId,
                Value<String> completedSteps = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StepProgressCompanion.insert(
                id: id,
                faultId: faultId,
                completedSteps: completedSteps,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StepProgressTable, StepProgressData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StepProgressTable,
                    StepProgressData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StepProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StepProgressTable,
      StepProgressData,
      $$StepProgressTableFilterComposer,
      $$StepProgressTableOrderingComposer,
      $$StepProgressTableAnnotationComposer,
      $$StepProgressTableCreateCompanionBuilder,
      $$StepProgressTableUpdateCompanionBuilder,
      (
        StepProgressData,
        BaseReferences<_$AppDatabase, $StepProgressTable, StepProgressData>,
      ),
      StepProgressData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
  $$StepProgressTableTableManager get stepProgress =>
      $$StepProgressTableTableManager(_db, _db.stepProgress);
}
