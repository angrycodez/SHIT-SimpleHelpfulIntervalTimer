
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  late final StreamController<String?> editModeChangedStream;

  SessionCubit(Session session) : super(SessionState(session)){
    editModeChangedStream = StreamController<String?>.broadcast();
  }

  void editModeChanged(String? stepId){
    editModeChangedStream.sink.add(stepId);
  }
}
