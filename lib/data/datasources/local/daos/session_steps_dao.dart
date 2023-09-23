import 'package:drift/drift.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';
import 'package:simple_interval_timer/data/datasources/local/tables.dart';

import 'models.dart';

part 'session_steps_dao.g.dart';

@DriftAccessor(tables: [Sessions])
class SessionStepsDao extends DatabaseAccessor<SessionDatabase>
    with _$SessionStepsDaoMixin {
  SessionStepsDao(SessionDatabase db) : super(db);

  Future<List<SessionStepEntry>> getSessionSteps(String sessionId) async {
    // get list of all steps for a session
    var blocks = await (db.sessionBlocks.select()
      ..where((tbl) => tbl.sessionId.equals(sessionId)))
        .get();
    var intervals = await (db.sessionIntervals.select()
      ..where((tbl) => tbl.sessionId.equals(sessionId)))
        .get();
    var steps = [...blocks, ...intervals];
    steps.sort((SessionStepEntry a, SessionStepEntry b) => a.sequenceIndex.compareTo(b.sequenceIndex));
    return steps;
  }

  Future<SessionBlockEntry?> getSessionBlock(String id) async{
    return await (db.sessionBlocks.select()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
  Future<SessionIntervalEntry?> getSessionInterval(String id) async{
    return await (db.sessionIntervals.select()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future updateSessionBlock({
    required String id,
    String? name,
    String? parentBlockId,
    int? sequenceIndex,
    int? repetitions,
  }) async {
    await db.sessionBlocks.insertOnConflictUpdate(SessionBlocksCompanion(
      id: Value(id),
      name: name != null ? Value(name) : const Value.absent(),
      parentBlockId: parentBlockId != null ? Value(parentBlockId) : const Value.absent(),
      sequenceIndex:
      sequenceIndex != null ? Value(sequenceIndex) : const Value.absent(),
      repetitions: repetitions != null ? Value(repetitions) : const Value.absent(),
    ));
  }

  Future updateSessionInterval({
    required String id,
    String? name,
    String? parentStepId,
    int? sequenceIndex,
    int? durationInSeconds,
    bool? isPause,
    String? startSoundId,
    String? endSoundId,
    int? color,
  }) async {
    await db.sessionIntervals.insertOnConflictUpdate(SessionIntervalsCompanion(
      id: Value(id),
      name: name != null ? Value(name) : const Value.absent(),
      parentBlockId: parentStepId != null ? Value(parentStepId) : const Value.absent(),
      sequenceIndex:
      sequenceIndex != null ? Value(sequenceIndex) : const Value.absent(),
      durationInSeconds: durationInSeconds != null ? Value(durationInSeconds) : const Value.absent(),
      isPause: isPause != null ? Value(isPause) : const Value.absent(),
      startSoundId: startSoundId != null ? Value(startSoundId) : const Value.absent(),
      color: color != null ? Value(color) : const Value.absent(),
    ));
  }

  Future deleteSessionInterval(String id) async{
    // delete the session with the given id; fix sequence indices for other steps with same parent
    await db.sessionIntervals.deleteWhere((tbl) => tbl.id.equals(id));
  }
  Future deleteSessionBlock(String id) async{
    // delete the session with the given id; fix sequence indices for other steps with same parent
    var block = await getSessionBlock(id);
    if(block == null){
      return;
    }
    await db.sessionIntervals.deleteWhere((tbl) => tbl.parentBlockId.equals(block.id));
    await db.sessionBlocks.deleteWhere((tbl) => tbl.parentBlockId.equals(block.id));
    await db.sessionBlocks.deleteWhere((tbl) => tbl.id.equals(id));
  }
}
