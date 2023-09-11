import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/models.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  SessionOverviewStateInitialized get _state {
    assert(state is SessionOverviewStateInitialized);
    return state as SessionOverviewStateInitialized;
  }
  SessionOverviewCubit(List<Session> sessions) : super(SessionOverviewState()){
    emit(SessionOverviewStateInitialized(sessions.map((e) => SessionCubit(e)).toList()));
  }

  SessionCubit? createNewSession(){
    if(state is SessionOverviewStateInitialized) {
      var sessions = List.of(_state.sessions);
      var sessionCubit = SessionCubit(Session(const Uuid().v4(), "New Session", "", List.empty()));
      sessions.add(sessionCubit);

      emit(_state.copyWith(sessions: sessions));
      return sessionCubit;
    }
  }

}
