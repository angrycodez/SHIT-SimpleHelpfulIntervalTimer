// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SoundsTable extends Sounds with TableInfo<$SoundsTable, SoundEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoundsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, filename, path];
  @override
  String get aliasedName => _alias ?? 'sounds';
  @override
  String get actualTableName => 'sounds';
  @override
  VerificationContext validateIntegrity(Insertable<SoundEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoundEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoundEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
    );
  }

  @override
  $SoundsTable createAlias(String alias) {
    return $SoundsTable(attachedDatabase, alias);
  }
}

class SoundEntry extends DataClass implements Insertable<SoundEntry> {
  final String id;
  final String filename;
  final String path;
  const SoundEntry(
      {required this.id, required this.filename, required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['filename'] = Variable<String>(filename);
    map['path'] = Variable<String>(path);
    return map;
  }

  SoundsCompanion toCompanion(bool nullToAbsent) {
    return SoundsCompanion(
      id: Value(id),
      filename: Value(filename),
      path: Value(path),
    );
  }

  factory SoundEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoundEntry(
      id: serializer.fromJson<String>(json['id']),
      filename: serializer.fromJson<String>(json['filename']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'filename': serializer.toJson<String>(filename),
      'path': serializer.toJson<String>(path),
    };
  }

  SoundEntry copyWith({String? id, String? filename, String? path}) =>
      SoundEntry(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        path: path ?? this.path,
      );
  @override
  String toString() {
    return (StringBuffer('SoundEntry(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, filename, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoundEntry &&
          other.id == this.id &&
          other.filename == this.filename &&
          other.path == this.path);
}

class SoundsCompanion extends UpdateCompanion<SoundEntry> {
  final Value<String> id;
  final Value<String> filename;
  final Value<String> path;
  final Value<int> rowid;
  const SoundsCompanion({
    this.id = const Value.absent(),
    this.filename = const Value.absent(),
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoundsCompanion.insert({
    this.id = const Value.absent(),
    required String filename,
    required String path,
    this.rowid = const Value.absent(),
  })  : filename = Value(filename),
        path = Value(path);
  static Insertable<SoundEntry> custom({
    Expression<String>? id,
    Expression<String>? filename,
    Expression<String>? path,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filename != null) 'filename': filename,
      if (path != null) 'path': path,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoundsCompanion copyWith(
      {Value<String>? id,
      Value<String>? filename,
      Value<String>? path,
      Value<int>? rowid}) {
    return SoundsCompanion(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      path: path ?? this.path,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoundsCompanion(')
          ..write('id: $id, ')
          ..write('filename: $filename, ')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 0,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description =
      GeneratedColumn<String>('description', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 0,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _endSoundIdMeta =
      const VerificationMeta('endSoundId');
  @override
  late final GeneratedColumn<String> endSoundId = GeneratedColumn<String>(
      'end_sound_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, description, endSoundId];
  @override
  String get aliasedName => _alias ?? 'sessions';
  @override
  String get actualTableName => 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<SessionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('end_sound_id')) {
      context.handle(
          _endSoundIdMeta,
          endSoundId.isAcceptableOrUnknown(
              data['end_sound_id']!, _endSoundIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      endSoundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_sound_id']),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionEntry extends DataClass implements Insertable<SessionEntry> {
  final String id;
  final String name;
  final String description;
  final String? endSoundId;
  const SessionEntry(
      {required this.id,
      required this.name,
      required this.description,
      this.endSoundId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || endSoundId != null) {
      map['end_sound_id'] = Variable<String>(endSoundId);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      endSoundId: endSoundId == null && nullToAbsent
          ? const Value.absent()
          : Value(endSoundId),
    );
  }

  factory SessionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      endSoundId: serializer.fromJson<String?>(json['endSoundId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'endSoundId': serializer.toJson<String?>(endSoundId),
    };
  }

  SessionEntry copyWith(
          {String? id,
          String? name,
          String? description,
          Value<String?> endSoundId = const Value.absent()}) =>
      SessionEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        endSoundId: endSoundId.present ? endSoundId.value : this.endSoundId,
      );
  @override
  String toString() {
    return (StringBuffer('SessionEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('endSoundId: $endSoundId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, endSoundId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.endSoundId == this.endSoundId);
}

class SessionsCompanion extends UpdateCompanion<SessionEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> endSoundId;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.endSoundId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.endSoundId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        description = Value(description);
  static Insertable<SessionEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? endSoundId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (endSoundId != null) 'end_sound_id': endSoundId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? endSoundId,
      Value<int>? rowid}) {
    return SessionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      endSoundId: endSoundId ?? this.endSoundId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (endSoundId.present) {
      map['end_sound_id'] = Variable<String>(endSoundId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('endSoundId: $endSoundId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionBlocksTable extends SessionBlocks
    with TableInfo<$SessionBlocksTable, SessionBlockEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 0,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _parentBlockIdMeta =
      const VerificationMeta('parentBlockId');
  @override
  late final GeneratedColumn<String> parentBlockId = GeneratedColumn<String>(
      'parent_block_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES session_blocks (id)'));
  static const VerificationMeta _sequenceIndexMeta =
      const VerificationMeta('sequenceIndex');
  @override
  late final GeneratedColumn<int> sequenceIndex = GeneratedColumn<int>(
      'sequence_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repetitionsMeta =
      const VerificationMeta('repetitions');
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
      'repetitions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, sessionId, parentBlockId, sequenceIndex, repetitions];
  @override
  String get aliasedName => _alias ?? 'session_blocks';
  @override
  String get actualTableName => 'session_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<SessionBlockEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('parent_block_id')) {
      context.handle(
          _parentBlockIdMeta,
          parentBlockId.isAcceptableOrUnknown(
              data['parent_block_id']!, _parentBlockIdMeta));
    }
    if (data.containsKey('sequence_index')) {
      context.handle(
          _sequenceIndexMeta,
          sequenceIndex.isAcceptableOrUnknown(
              data['sequence_index']!, _sequenceIndexMeta));
    } else if (isInserting) {
      context.missing(_sequenceIndexMeta);
    }
    if (data.containsKey('repetitions')) {
      context.handle(
          _repetitionsMeta,
          repetitions.isAcceptableOrUnknown(
              data['repetitions']!, _repetitionsMeta));
    } else if (isInserting) {
      context.missing(_repetitionsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionBlockEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionBlockEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentBlockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_block_id']),
      sequenceIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_index'])!,
      repetitions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repetitions'])!,
    );
  }

  @override
  $SessionBlocksTable createAlias(String alias) {
    return $SessionBlocksTable(attachedDatabase, alias);
  }
}

class SessionBlocksCompanion extends UpdateCompanion<SessionBlockEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> sessionId;
  final Value<String?> parentBlockId;
  final Value<int> sequenceIndex;
  final Value<int> repetitions;
  final Value<int> rowid;
  const SessionBlocksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.parentBlockId = const Value.absent(),
    this.sequenceIndex = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionBlocksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String sessionId,
    this.parentBlockId = const Value.absent(),
    required int sequenceIndex,
    required int repetitions,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        sessionId = Value(sessionId),
        sequenceIndex = Value(sequenceIndex),
        repetitions = Value(repetitions);
  static Insertable<SessionBlockEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sessionId,
    Expression<String>? parentBlockId,
    Expression<int>? sequenceIndex,
    Expression<int>? repetitions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sessionId != null) 'session_id': sessionId,
      if (parentBlockId != null) 'parent_block_id': parentBlockId,
      if (sequenceIndex != null) 'sequence_index': sequenceIndex,
      if (repetitions != null) 'repetitions': repetitions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionBlocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? sessionId,
      Value<String?>? parentBlockId,
      Value<int>? sequenceIndex,
      Value<int>? repetitions,
      Value<int>? rowid}) {
    return SessionBlocksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sessionId: sessionId ?? this.sessionId,
      parentBlockId: parentBlockId ?? this.parentBlockId,
      sequenceIndex: sequenceIndex ?? this.sequenceIndex,
      repetitions: repetitions ?? this.repetitions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (parentBlockId.present) {
      map['parent_block_id'] = Variable<String>(parentBlockId.value);
    }
    if (sequenceIndex.present) {
      map['sequence_index'] = Variable<int>(sequenceIndex.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionBlocksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sessionId: $sessionId, ')
          ..write('parentBlockId: $parentBlockId, ')
          ..write('sequenceIndex: $sequenceIndex, ')
          ..write('repetitions: $repetitions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionIntervalsTable extends SessionIntervals
    with TableInfo<$SessionIntervalsTable, SessionIntervalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionIntervalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 0,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _parentBlockIdMeta =
      const VerificationMeta('parentBlockId');
  @override
  late final GeneratedColumn<String> parentBlockId = GeneratedColumn<String>(
      'parent_block_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES session_blocks (id)'));
  static const VerificationMeta _sequenceIndexMeta =
      const VerificationMeta('sequenceIndex');
  @override
  late final GeneratedColumn<int> sequenceIndex = GeneratedColumn<int>(
      'sequence_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationInSecondsMeta =
      const VerificationMeta('durationInSeconds');
  @override
  late final GeneratedColumn<int> durationInSeconds = GeneratedColumn<int>(
      'duration_in_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isPauseMeta =
      const VerificationMeta('isPause');
  @override
  late final GeneratedColumn<bool> isPause = GeneratedColumn<bool>(
      'is_pause', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pause" IN (0, 1))'));
  static const VerificationMeta _startSoundIdMeta =
      const VerificationMeta('startSoundId');
  @override
  late final GeneratedColumn<String> startSoundId = GeneratedColumn<String>(
      'start_sound_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  static const VerificationMeta _endSoundIdMeta =
      const VerificationMeta('endSoundId');
  @override
  late final GeneratedColumn<String> endSoundId = GeneratedColumn<String>(
      'end_sound_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        sessionId,
        parentBlockId,
        sequenceIndex,
        durationInSeconds,
        isPause,
        startSoundId,
        endSoundId,
        color
      ];
  @override
  String get aliasedName => _alias ?? 'session_intervals';
  @override
  String get actualTableName => 'session_intervals';
  @override
  VerificationContext validateIntegrity(
      Insertable<SessionIntervalEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('parent_block_id')) {
      context.handle(
          _parentBlockIdMeta,
          parentBlockId.isAcceptableOrUnknown(
              data['parent_block_id']!, _parentBlockIdMeta));
    }
    if (data.containsKey('sequence_index')) {
      context.handle(
          _sequenceIndexMeta,
          sequenceIndex.isAcceptableOrUnknown(
              data['sequence_index']!, _sequenceIndexMeta));
    } else if (isInserting) {
      context.missing(_sequenceIndexMeta);
    }
    if (data.containsKey('duration_in_seconds')) {
      context.handle(
          _durationInSecondsMeta,
          durationInSeconds.isAcceptableOrUnknown(
              data['duration_in_seconds']!, _durationInSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationInSecondsMeta);
    }
    if (data.containsKey('is_pause')) {
      context.handle(_isPauseMeta,
          isPause.isAcceptableOrUnknown(data['is_pause']!, _isPauseMeta));
    } else if (isInserting) {
      context.missing(_isPauseMeta);
    }
    if (data.containsKey('start_sound_id')) {
      context.handle(
          _startSoundIdMeta,
          startSoundId.isAcceptableOrUnknown(
              data['start_sound_id']!, _startSoundIdMeta));
    }
    if (data.containsKey('end_sound_id')) {
      context.handle(
          _endSoundIdMeta,
          endSoundId.isAcceptableOrUnknown(
              data['end_sound_id']!, _endSoundIdMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionIntervalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionIntervalEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      parentBlockId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_block_id']),
      sequenceIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence_index'])!,
      durationInSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}duration_in_seconds'])!,
      isPause: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pause'])!,
      startSoundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_sound_id']),
      endSoundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_sound_id']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $SessionIntervalsTable createAlias(String alias) {
    return $SessionIntervalsTable(attachedDatabase, alias);
  }
}

class SessionIntervalsCompanion extends UpdateCompanion<SessionIntervalEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> sessionId;
  final Value<String?> parentBlockId;
  final Value<int> sequenceIndex;
  final Value<int> durationInSeconds;
  final Value<bool> isPause;
  final Value<String?> startSoundId;
  final Value<String?> endSoundId;
  final Value<int> color;
  final Value<int> rowid;
  const SessionIntervalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.parentBlockId = const Value.absent(),
    this.sequenceIndex = const Value.absent(),
    this.durationInSeconds = const Value.absent(),
    this.isPause = const Value.absent(),
    this.startSoundId = const Value.absent(),
    this.endSoundId = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionIntervalsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String sessionId,
    this.parentBlockId = const Value.absent(),
    required int sequenceIndex,
    required int durationInSeconds,
    required bool isPause,
    this.startSoundId = const Value.absent(),
    this.endSoundId = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        sessionId = Value(sessionId),
        sequenceIndex = Value(sequenceIndex),
        durationInSeconds = Value(durationInSeconds),
        isPause = Value(isPause);
  static Insertable<SessionIntervalEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sessionId,
    Expression<String>? parentBlockId,
    Expression<int>? sequenceIndex,
    Expression<int>? durationInSeconds,
    Expression<bool>? isPause,
    Expression<String>? startSoundId,
    Expression<String>? endSoundId,
    Expression<int>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sessionId != null) 'session_id': sessionId,
      if (parentBlockId != null) 'parent_block_id': parentBlockId,
      if (sequenceIndex != null) 'sequence_index': sequenceIndex,
      if (durationInSeconds != null) 'duration_in_seconds': durationInSeconds,
      if (isPause != null) 'is_pause': isPause,
      if (startSoundId != null) 'start_sound_id': startSoundId,
      if (endSoundId != null) 'end_sound_id': endSoundId,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionIntervalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? sessionId,
      Value<String?>? parentBlockId,
      Value<int>? sequenceIndex,
      Value<int>? durationInSeconds,
      Value<bool>? isPause,
      Value<String?>? startSoundId,
      Value<String?>? endSoundId,
      Value<int>? color,
      Value<int>? rowid}) {
    return SessionIntervalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sessionId: sessionId ?? this.sessionId,
      parentBlockId: parentBlockId ?? this.parentBlockId,
      sequenceIndex: sequenceIndex ?? this.sequenceIndex,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
      isPause: isPause ?? this.isPause,
      startSoundId: startSoundId ?? this.startSoundId,
      endSoundId: endSoundId ?? this.endSoundId,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (parentBlockId.present) {
      map['parent_block_id'] = Variable<String>(parentBlockId.value);
    }
    if (sequenceIndex.present) {
      map['sequence_index'] = Variable<int>(sequenceIndex.value);
    }
    if (durationInSeconds.present) {
      map['duration_in_seconds'] = Variable<int>(durationInSeconds.value);
    }
    if (isPause.present) {
      map['is_pause'] = Variable<bool>(isPause.value);
    }
    if (startSoundId.present) {
      map['start_sound_id'] = Variable<String>(startSoundId.value);
    }
    if (endSoundId.present) {
      map['end_sound_id'] = Variable<String>(endSoundId.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sessionId: $sessionId, ')
          ..write('parentBlockId: $parentBlockId, ')
          ..write('sequenceIndex: $sequenceIndex, ')
          ..write('durationInSeconds: $durationInSeconds, ')
          ..write('isPause: $isPause, ')
          ..write('startSoundId: $startSoundId, ')
          ..write('endSoundId: $endSoundId, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _defaultIntervalStartSoundMeta =
      const VerificationMeta('defaultIntervalStartSound');
  @override
  late final GeneratedColumn<String> defaultIntervalStartSound =
      GeneratedColumn<String>('default_interval_start_sound', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints:
              GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  static const VerificationMeta _defaultIntervalEndSoundMeta =
      const VerificationMeta('defaultIntervalEndSound');
  @override
  late final GeneratedColumn<String> defaultIntervalEndSound =
      GeneratedColumn<String>('default_interval_end_sound', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints:
              GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  static const VerificationMeta _defaultSessionEndSoundMeta =
      const VerificationMeta('defaultSessionEndSound');
  @override
  late final GeneratedColumn<String> defaultSessionEndSound =
      GeneratedColumn<String>('default_session_end_sound', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints:
              GeneratedColumn.constraintIsAlways('REFERENCES sounds (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        defaultIntervalStartSound,
        defaultIntervalEndSound,
        defaultSessionEndSound
      ];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('default_interval_start_sound')) {
      context.handle(
          _defaultIntervalStartSoundMeta,
          defaultIntervalStartSound.isAcceptableOrUnknown(
              data['default_interval_start_sound']!,
              _defaultIntervalStartSoundMeta));
    }
    if (data.containsKey('default_interval_end_sound')) {
      context.handle(
          _defaultIntervalEndSoundMeta,
          defaultIntervalEndSound.isAcceptableOrUnknown(
              data['default_interval_end_sound']!,
              _defaultIntervalEndSoundMeta));
    }
    if (data.containsKey('default_session_end_sound')) {
      context.handle(
          _defaultSessionEndSoundMeta,
          defaultSessionEndSound.isAcceptableOrUnknown(
              data['default_session_end_sound']!, _defaultSessionEndSoundMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      defaultIntervalStartSound: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_interval_start_sound']),
      defaultIntervalEndSound: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_interval_end_sound']),
      defaultSessionEndSound: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_session_end_sound']),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingsEntry extends DataClass implements Insertable<SettingsEntry> {
  final String id;
  final String? defaultIntervalStartSound;
  final String? defaultIntervalEndSound;
  final String? defaultSessionEndSound;
  const SettingsEntry(
      {required this.id,
      this.defaultIntervalStartSound,
      this.defaultIntervalEndSound,
      this.defaultSessionEndSound});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || defaultIntervalStartSound != null) {
      map['default_interval_start_sound'] =
          Variable<String>(defaultIntervalStartSound);
    }
    if (!nullToAbsent || defaultIntervalEndSound != null) {
      map['default_interval_end_sound'] =
          Variable<String>(defaultIntervalEndSound);
    }
    if (!nullToAbsent || defaultSessionEndSound != null) {
      map['default_session_end_sound'] =
          Variable<String>(defaultSessionEndSound);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      defaultIntervalStartSound:
          defaultIntervalStartSound == null && nullToAbsent
              ? const Value.absent()
              : Value(defaultIntervalStartSound),
      defaultIntervalEndSound: defaultIntervalEndSound == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultIntervalEndSound),
      defaultSessionEndSound: defaultSessionEndSound == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSessionEndSound),
    );
  }

  factory SettingsEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntry(
      id: serializer.fromJson<String>(json['id']),
      defaultIntervalStartSound:
          serializer.fromJson<String?>(json['defaultIntervalStartSound']),
      defaultIntervalEndSound:
          serializer.fromJson<String?>(json['defaultIntervalEndSound']),
      defaultSessionEndSound:
          serializer.fromJson<String?>(json['defaultSessionEndSound']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'defaultIntervalStartSound':
          serializer.toJson<String?>(defaultIntervalStartSound),
      'defaultIntervalEndSound':
          serializer.toJson<String?>(defaultIntervalEndSound),
      'defaultSessionEndSound':
          serializer.toJson<String?>(defaultSessionEndSound),
    };
  }

  SettingsEntry copyWith(
          {String? id,
          Value<String?> defaultIntervalStartSound = const Value.absent(),
          Value<String?> defaultIntervalEndSound = const Value.absent(),
          Value<String?> defaultSessionEndSound = const Value.absent()}) =>
      SettingsEntry(
        id: id ?? this.id,
        defaultIntervalStartSound: defaultIntervalStartSound.present
            ? defaultIntervalStartSound.value
            : this.defaultIntervalStartSound,
        defaultIntervalEndSound: defaultIntervalEndSound.present
            ? defaultIntervalEndSound.value
            : this.defaultIntervalEndSound,
        defaultSessionEndSound: defaultSessionEndSound.present
            ? defaultSessionEndSound.value
            : this.defaultSessionEndSound,
      );
  @override
  String toString() {
    return (StringBuffer('SettingsEntry(')
          ..write('id: $id, ')
          ..write('defaultIntervalStartSound: $defaultIntervalStartSound, ')
          ..write('defaultIntervalEndSound: $defaultIntervalEndSound, ')
          ..write('defaultSessionEndSound: $defaultSessionEndSound')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, defaultIntervalStartSound,
      defaultIntervalEndSound, defaultSessionEndSound);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntry &&
          other.id == this.id &&
          other.defaultIntervalStartSound == this.defaultIntervalStartSound &&
          other.defaultIntervalEndSound == this.defaultIntervalEndSound &&
          other.defaultSessionEndSound == this.defaultSessionEndSound);
}

class SettingsCompanion extends UpdateCompanion<SettingsEntry> {
  final Value<String> id;
  final Value<String?> defaultIntervalStartSound;
  final Value<String?> defaultIntervalEndSound;
  final Value<String?> defaultSessionEndSound;
  final Value<int> rowid;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.defaultIntervalStartSound = const Value.absent(),
    this.defaultIntervalEndSound = const Value.absent(),
    this.defaultSessionEndSound = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.defaultIntervalStartSound = const Value.absent(),
    this.defaultIntervalEndSound = const Value.absent(),
    this.defaultSessionEndSound = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<SettingsEntry> custom({
    Expression<String>? id,
    Expression<String>? defaultIntervalStartSound,
    Expression<String>? defaultIntervalEndSound,
    Expression<String>? defaultSessionEndSound,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (defaultIntervalStartSound != null)
        'default_interval_start_sound': defaultIntervalStartSound,
      if (defaultIntervalEndSound != null)
        'default_interval_end_sound': defaultIntervalEndSound,
      if (defaultSessionEndSound != null)
        'default_session_end_sound': defaultSessionEndSound,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? defaultIntervalStartSound,
      Value<String?>? defaultIntervalEndSound,
      Value<String?>? defaultSessionEndSound,
      Value<int>? rowid}) {
    return SettingsCompanion(
      id: id ?? this.id,
      defaultIntervalStartSound:
          defaultIntervalStartSound ?? this.defaultIntervalStartSound,
      defaultIntervalEndSound:
          defaultIntervalEndSound ?? this.defaultIntervalEndSound,
      defaultSessionEndSound:
          defaultSessionEndSound ?? this.defaultSessionEndSound,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (defaultIntervalStartSound.present) {
      map['default_interval_start_sound'] =
          Variable<String>(defaultIntervalStartSound.value);
    }
    if (defaultIntervalEndSound.present) {
      map['default_interval_end_sound'] =
          Variable<String>(defaultIntervalEndSound.value);
    }
    if (defaultSessionEndSound.present) {
      map['default_session_end_sound'] =
          Variable<String>(defaultSessionEndSound.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('defaultIntervalStartSound: $defaultIntervalStartSound, ')
          ..write('defaultIntervalEndSound: $defaultIntervalEndSound, ')
          ..write('defaultSessionEndSound: $defaultSessionEndSound, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SessionDatabase extends GeneratedDatabase {
  _$SessionDatabase(QueryExecutor e) : super(e);
  late final $SoundsTable sounds = $SoundsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionBlocksTable sessionBlocks = $SessionBlocksTable(this);
  late final $SessionIntervalsTable sessionIntervals =
      $SessionIntervalsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final SessionsDao sessionsDao = SessionsDao(this as SessionDatabase);
  late final SessionStepsDao sessionStepsDao =
      SessionStepsDao(this as SessionDatabase);
  late final SoundsDao soundsDao = SoundsDao(this as SessionDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as SessionDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sounds, sessions, sessionBlocks, sessionIntervals, settings];
}
