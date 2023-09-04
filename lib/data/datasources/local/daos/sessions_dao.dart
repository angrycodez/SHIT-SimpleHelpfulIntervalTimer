import 'package:drift/drift.dart';
import 'package:simple_interval_timer/data/datasources/local/daos/daos.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';
import 'package:simple_interval_timer/data/datasources/local/tables.dart';

part 'sessions_dao.g.dart';

@DriftAccessor(tables: [Sessions])
class SessionsDao extends DatabaseAccessor<SessionDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(SessionDatabase db) : super(db);

  Future<List<SessionEntry>> getSessionsOverview() async {
    // get list of existing sessions
    return await db.sessions.select().get();
  }

  Future<bool> sessionExists(String id)async{
    return await getSession(id) != null;
  }

  Future<SessionEntry?> getSession(String id)async{
    // get a session entry for the given id
    return await (db.sessions.select()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future updateSession({required String id, String? name})async{
    // update the values of a session
    await db.sessions.insertOnConflictUpdate(SessionsCompanion(id: Value(id), name: name != null ? Value(name) : const Value.absent()));
  }

  Future deleteSession(String id)async{
    // delete the session with the given id
    var session = await getSession(id);
    if(session == null){
      return;
    }
    await db.sessionIntervals.deleteWhere((tbl) => tbl.parentBlockId.equals(session.id));
    await db.sessionBlocks.deleteWhere((tbl) => tbl.parentBlockId.equals(session.id));
    await db.sessions.deleteWhere((tbl) => tbl.id.equals(id));
  }

}