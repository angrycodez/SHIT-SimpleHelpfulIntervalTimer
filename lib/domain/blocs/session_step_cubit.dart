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
    this.sessionCubit,
  {
    required this.moveUp,
    required this.moveDown,
    required this.canMoveUp,
    required this.canMoveDown,
    required this.delete,
  }
  ) : super(sessionStep is SessionBlock
            ? SessionBlockState.fromBlock(sessionStep, sessionCubit)
            : SessionIntervalState.fromInterval(
                sessionStep as SessionInterval)) {
    sessionCubit.editModeChangedStream.stream.listen(onEditModeChanged);
  }

  // if referenceStep is null, use movingStep for reference
  void Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep}) moveUp;
  bool Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep}) canMoveUp;
  void Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep}) moveDown;
  bool Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep}) canMoveDown;

  void Function(SessionStepCubit deletedStep) delete;

  void onEditModeChanged(String? editStepId) {
    if(editStepId != state.id) {
      emit(state.copyWith(isEditMode: false));
    }
  }

  void setEditMode() {
    sessionCubit.editModeChanged(state.id);
    emit(state.copyWith(isEditMode: true));
  }

  static SessionStepCubit getCubit(
      SessionStep sessionStep, SessionCubit sessionCubit) {
    return sessionStep is SessionBlock
        ? SessionBlockCubit(sessionStep as SessionBlock, sessionCubit)
        : SessionIntervalCubit(sessionStep as SessionInterval, sessionCubit);
  }
}
