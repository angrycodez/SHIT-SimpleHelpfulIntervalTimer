import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_step_state.dart';

abstract class SessionStepCubit extends Cubit<SessionStepState> {
  SessionCubit sessionCubit;
  SessionStepCubit(
    SessionStep sessionStep,
    this.sessionCubit, ) : super(sessionStep is SessionBlock
            ? SessionBlockState.fromBlock(sessionStep, sessionCubit)
            : SessionIntervalState.fromInterval(
                sessionStep as SessionInterval)) {
    sessionCubit.editModeChangedStream.listen(onEditModeChanged);
  }

  // if referenceStep is null, use movingStep for reference
  void moveUp(SessionStepCubit movingStep) => sessionCubit.moveUpChild(movingStep);
  void moveDown(SessionStepCubit movingStep) => sessionCubit.moveUpChild(movingStep);

  bool canMoveUp(SessionStepCubit movingStep)=>sessionCubit.canMoveUpChild(movingStep);
  bool canMoveDown(SessionStepCubit movingStep)=>sessionCubit.canMoveUpChild(movingStep);

  void delete(SessionStepCubit deletedStep){}

  void onEditModeChanged(String? editStepId) {
    if (editStepId != state.id) {
      emit(state.copyWith(isEditMode: false));
    }
  }

  void setEditMode() {
    sessionCubit.editModeChanged(state.id);
    emit(state.copyWith(isEditMode: true));
  }

  static SessionStepCubit getCubit(
    SessionStep sessionStep,
    SessionCubit sessionCubit,) {
    return sessionStep is SessionBlock
        ? SessionBlockCubit(sessionStep as SessionBlock, sessionCubit,)
        : SessionIntervalCubit(sessionStep as SessionInterval, sessionCubit,);
  }

  SessionStep getObject(int sequenceIndex, SessionBlock? parent) {
    return SessionStep(
      id: state.id,
      sequenceIndex: sequenceIndex,
      name: state.name,
      parentStep: parent,
    );
  }
}
