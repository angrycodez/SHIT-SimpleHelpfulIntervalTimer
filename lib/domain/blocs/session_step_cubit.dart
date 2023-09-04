import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_step_state.dart';

abstract class SessionStepCubit extends Cubit<SessionStepState> {
  SessionStepCubit(SessionStep sessionStep, SessionCubit sessionCubit,)
      : super(SessionStepState(sessionStep: sessionStep, sessionCubit: sessionCubit,)){
    sessionCubit.editModeChangedStream.stream.listen((event) {
      if(event != state.sessionStep) {
        emit(state.copyWith(isEditMode: false));
      }
    });
  }

  // if referenceStep is null, use movingStep for reference
  void moveUp(SessionStep movingStep, {SessionStep? referenceStep,}){}
  bool canMoveUp(SessionStep movingStep, {SessionStep? referenceStep,}){return false;}
  void moveDown(SessionStep movingStep, {SessionStep? referenceStep,}){}
  bool canMoveDown(SessionStep movingStep, {SessionStep? referenceStep,}){return false;}
  void delete(){}

  void setEditMode(){
    state.sessionCubit.editModeChanged(state.sessionStep);
    emit(state.copyWith(isEditMode: true));
  }


  static SessionStepCubit getCubit(SessionStep sessionStep, SessionCubit sessionCubit){
    return
      sessionStep is SessionBlock
        ? SessionBlockCubit(sessionStep as SessionBlock, sessionCubit)
        : SessionIntervalCubit(sessionStep as SessionInterval, sessionCubit);

  }

}
