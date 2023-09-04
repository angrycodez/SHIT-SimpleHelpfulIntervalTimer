import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  SessionOverviewCubit(List<Session> sessions) : super(SessionOverviewState(sessions));

}
