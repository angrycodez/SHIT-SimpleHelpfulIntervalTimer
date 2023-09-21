import 'package:drift/drift.dart';
import 'package:simple_interval_timer/data/datasources/local/daos/daos.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';
import 'package:simple_interval_timer/data/datasources/local/tables.dart';
import 'package:simple_interval_timer/data/models/models.dart';

part 'sessions_dao.g.dart';

@DriftAccessor(tables: [Sessions])
class SessionsDao extends DatabaseAccessor<SessionDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(SessionDatabase db) : super(db);

  Future<List<SessionEntry>> getSessionsOverview() async {
    // get list of existing sessions
    return await db.sessions.select().get();
  }

  Future<bool> sessionExists(String id) async {
    return await getSession(id) != null;
  }

  Future<SessionEntry?> getSession(String id) async {
    // get a session entry for the given id
    return await (db.sessions.select()..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future updateSession(Session session) async {
    // update the values of a session
    var allSteps = session.distinctSteps;
    var intervals = allSteps.whereType<SessionInterval>().toList();
    var blocks = allSteps.whereType<SessionBlock>().toList();
    await db.sessionIntervals
        .deleteWhere((tbl) =>  tbl.sessionId.equals(session.id) & tbl.id.isNotIn(intervals.map((e) => e.id)));
    await db.sessionBlocks
        .deleteWhere((tbl) => tbl.sessionId.equals(session.id) & tbl.id.isNotIn(blocks.map((e) => e.id)));

    await db.sessions.insertOnConflictUpdate(SessionsCompanion(
      id: Value(session.id),
      name: Value(session.name),
      description: Value(session.description),
    ));

    for (var block in blocks) {
      await db.sessionBlocks.insertOnConflictUpdate(
        SessionBlocksCompanion(
          id: Value(block.id),
          name: Value(block.name),
          sessionId: Value(session.id),
          parentBlockId: Value(block.parentStep?.id),
          sequenceIndex: Value(block.sequenceIndex),
          repetitions: Value(block.repetitions),
        ),
      );
    }
    for (var interval in intervals) {
      await db.sessionIntervals.insertOnConflictUpdate(
        SessionIntervalsCompanion(
          id: Value(interval.id),
          name: Value(interval.name),
          sessionId: Value(session.id),
          parentBlockId: Value(interval.parentStep?.id),
          sequenceIndex: Value(interval.sequenceIndex),
          durationInSeconds: Value(interval.duration.inSeconds),
          isPause: Value(interval.isPause),
          startSoundId: Value(interval.startSound?.id),
          endSoundId: Value(interval.endSound?.id),
          color: Value(interval.color.value),
        ),
      );
    }
  }

  Future deleteSession(String sessionId) async {
    // delete the session with the given id
    if (!await sessionExists(sessionId)) {
      return;
    }
    await db.sessionIntervals
        .deleteWhere((tbl) => tbl.sessionId.equals(sessionId));
    await db.sessionBlocks
        .deleteWhere((tbl) => tbl.sessionId.equals(sessionId));
    await db.sessions.deleteWhere((tbl) => tbl.id.equals(sessionId));
  }
}
