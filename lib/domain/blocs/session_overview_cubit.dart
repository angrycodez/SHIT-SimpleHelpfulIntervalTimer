import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/models.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  SessionOverviewCubit(List<Session> sessions) : super(SessionOverviewState(sessions));

  void createNewSession(){
    var sessions = List.of(state.sessions);
    sessions.add(Session(const Uuid().v4(), "New Session", List.empty()));
    emit(state.copyWith(sessions: sessions));
  }

}
