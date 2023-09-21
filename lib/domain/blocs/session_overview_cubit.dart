import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/models.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  late List<SessionCubit> sessions;
  final SessionDatabaseCubit _databaseCubit;

  SessionOverviewCubit(this._databaseCubit)
      : super(SessionOverviewState(List.empty())) {
    loadSessions();
  }

  Future loadSessions() async {
    var sessions = await _databaseCubit.sessionRepository.getSessions();
    this.sessions =
        sessions.map((e) => SessionCubit(e, deleteSession)).toList();
    emit(SessionOverviewState(this.sessions));
  }

  SessionCubit? createNewSession() {
    var sessions = List.of(state.sessions);
    var sessionCubit = SessionCubit(
      Session(const Uuid().v4(), "New Session", "", List.empty()),
      deleteSession,
    );
    sessions.add(sessionCubit);

    emit(state.copyWith(sessions: sessions));
    return sessionCubit;
  }

  Future deleteSession(String sessionId) async {
    await _databaseCubit.sessionRepository.deleteSession(sessionId);
    loadSessions();
  }
}
