
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:simple_interval_timer/data/datasources/local/daos/daos.dart';
import 'package:simple_interval_timer/data/datasources/local/tables.dart';
import 'package:uuid/uuid.dart';

import 'daos/models.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Sessions,
    SessionBlocks,
    SessionIntervals,
    Sounds,
    Settings,
  ],
  daos: [
    SessionsDao,
    SessionStepsDao,
    SoundsDao,
    SettingsDao
  ],
)
class SessionDatabase extends _$SessionDatabase {
  SessionDatabase() : super(openConnection());

  // SessionDatabase.connect(DatabaseConnection connection)
  //   : super.connect(connection);

  @override
  int get schemaVersion => 1;


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: ((Migrator m, int from, int to) async {
      for (var step = from + 1; step <= to; step++) {
        switch (step) {
        }
      }
    }), beforeOpen: ((details) async {
      await customStatement('PRAGMA foreign_keys = ON');

      if (details.wasCreated) {
        settings.insertOne(SettingsCompanion.insert(id: Value(const Uuid().v4()),));

        sessions.insertOne(SessionsCompanion.insert(id: const Value("1") ,name: "Test", description: "Eine Testsession"));

        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: const Value("1"), name: "first",sequenceIndex: 0, durationInSeconds: 10, isPause: false,));

        sessionBlocks.insertOne(SessionBlocksCompanion.insert(sessionId: "1", id: const Value("2"), name: "first_block", sequenceIndex: 1, repetitions: 2,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: const Value("4"), name: "second_in_block", parentBlockId: const Value("2"),sequenceIndex: 1, durationInSeconds: 2, isPause: true,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: const Value("3"), name: "first_in_block", parentBlockId: const Value("2"),sequenceIndex: 0, durationInSeconds: 10, isPause: false,));

        sessionBlocks.insertOne(SessionBlocksCompanion.insert(sessionId: "1", id: const Value("5"), name: "second_block", sequenceIndex: 2, repetitions: 5,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: const Value("6"), name: "second_in_block", parentBlockId: const Value("5"),sequenceIndex: 1, durationInSeconds: 42, isPause: true,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: const Value("7"), name: "first_in_block", parentBlockId: const Value("5"),sequenceIndex: 0, durationInSeconds: 3, isPause: true,));

      }
    }));
  }
}


LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'shit/db.sqlite'));
    return NativeDatabase(file);
  });
}
