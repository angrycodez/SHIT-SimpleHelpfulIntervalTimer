import 'package:simple_interval_timer/data/datasources/local/daos/models.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';

import '../datasources/local/daos/daos.dart';
import '../models/models.dart';

class SessionRepository {
  final SessionDatabase _db;
  late SessionsDao _sessionsDao;
  late SessionStepsDao _sessionStepsDao;
  SessionRepository(this._db) {
    _sessionsDao = SessionsDao(_db);
    _sessionStepsDao = SessionStepsDao(_db);
  }

  Future<List<Session>> getSessions() async {
    List<SessionEntry> sessions = await _sessionsDao.getSessionsOverview();
    return (await Future.wait(sessions.map((s) async {
      return await getSession(s.id);
    })))
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  Future<Session?> getSession(String id) async {
    SessionEntry? sessionEntry = await _sessionsDao.getSession(id);
    if (sessionEntry == null) {
      return null;
    }

    List<SessionStepEntry> steps = await _sessionStepsDao.getSessionSteps(id);
    steps.sort((a, b) => a.sequenceIndex.compareTo(b.sequenceIndex));
    List<SessionStep> stepObjects = List.empty(growable: true);

    var baseSteps =
        steps.where((element) => element.parentBlockId == null).toList();
    for (var step in baseSteps) {
      if (step is SessionIntervalEntry) {
        // step is interval
        stepObjects.add(_getInterval(step, null,));
      } else if(step is SessionBlockEntry) {
        // step is block
        stepObjects.add(_getBlock(step, null, _getChildrenSteps(step, steps)),);
      }
    }

    Session session = Session(id, sessionEntry.name, sessionEntry.description, stepObjects);
    _addParentReferences(session.steps);
    return session;
  }

  void _addParentReferences(List<SessionStep> steps) {
    for (var step in steps) {
      if (step is SessionBlock) {
        for (int i = 0; i < step.children.length; i++) {
          var child = step.children[i];
          if (child is SessionInterval) {
            step.children[i] = child.copyWith(parentStep: step);
          } else if (child is SessionBlock) {
            step.children[i] = child.copyWith(parentStep: step);
            _addParentReferences(child.children);
          }
        }
      }
    }
  }

  SessionInterval _getInterval(SessionIntervalEntry entry, SessionBlock? parent) {
    return SessionInterval(
      id: entry.id,
      name: entry.name,
      parentStep: parent,
      sequenceIndex: entry.sequenceIndex,
      duration: Duration(seconds: entry.durationInSeconds),
      isPause: entry.isPause,
      startSound: null /*TODO: getStartSound*/,
      endSound: null /*TODO: getEndSound*/,
    );
  }

  SessionBlock _getBlock(SessionBlockEntry entry, SessionBlock? parent,
      List<SessionStep> children) {
    return SessionBlock(
      id: entry.id,
      name: entry.name,
      parentStep: parent,
      sequenceIndex: entry.sequenceIndex,
      repetitions: entry.repetitions,
      children: children,
    );
  }

  List<SessionStep> _getChildrenSteps(
    SessionStepEntry block,
    List<SessionStepEntry> steps,
  ) {
    var children =
        steps.where((element) => element.parentBlockId == block.id).toList();
    children.sort((a,b) => a.sequenceIndex.compareTo(b.sequenceIndex));
    List<SessionStep> childSteps = List.empty(growable: true);
    for (var child in children) {
      if (child is SessionBlockEntry) {
        childSteps.add(SessionBlock(
          id: child.id,
          name: child.name,
          sequenceIndex: child.sequenceIndex,
          repetitions: child.repetitions,
          children: _getChildrenSteps(child, steps),
        ));
      } else if(child is SessionIntervalEntry){
        childSteps.add(SessionInterval(
          id: child.id,
          name: child.name,
          sequenceIndex: child.sequenceIndex,
          duration: Duration(seconds: child.durationInSeconds),
          isPause: child.isPause,
          startSound: null, // TODO!
          endSound: null, // TODO!
        ));
      }
    }
    return childSteps;
  }

  void storeSession(Session session) {
    // TODO: delete all sessionSteps (blocks+intervals) that are no longer part of the session. Then, insertOnConflictUpdate all steps in the session and the session itself

  }
}
