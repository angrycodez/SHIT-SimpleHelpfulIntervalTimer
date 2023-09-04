
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
    Sessions, SessionBlocks, SessionIntervals, Sounds
  ],
  daos: [
    SessionsDao, SessionStepsDao
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
        sessions.insertOne(SessionsCompanion.insert(id: Value("1") ,name: "Test"));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: Value("1"), name: Value("first"),sequenceIndex: 0, durationInSeconds: 10, isPause: false,));
        sessionBlocks.insertOne(SessionBlocksCompanion.insert(sessionId: "1", id: Value("1"), name: Value("first_block"), sequenceIndex: 1, repetitions: 2,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: Value("3"), name: Value("second_in_block"), parentBlockId: Value("1"),sequenceIndex: 1, durationInSeconds: 2, isPause: true,));
        sessionIntervals.insertOne(SessionIntervalsCompanion.insert(sessionId: "1", id: Value("2"), name: Value("first_in_block"), parentBlockId: Value("1"),sequenceIndex: 0, durationInSeconds: 10, isPause: false,));
      }
    }));
  }
}


LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'sit/db.sqlite'));
    return NativeDatabase(file);
  });
}
