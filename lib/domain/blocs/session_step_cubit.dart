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
    sessionCubit.editModeChangedStream.listen(onSelectionChanged);
  }
  bool get hasChanges => state.hasChanges;

  @override
  Future<void> close() {
    return super.close();
  }

  // if referenceStep is null, use movingStep for reference
  void moveUp() => sessionCubit.moveUpChild(this);
  void moveDown() => sessionCubit.moveDownChild(this);

  bool canMoveUp()=>sessionCubit.canMoveUpChild(this);
  bool canMoveDown()=>sessionCubit.canMoveDownChild(this);

  void delete()=>sessionCubit.delete(this);

  void onSelectionChanged(String? editStepId) {
    if (editStepId != state.id) {
      emit(state.copyWith(isSelected: false, isEditMode: false));
    }
  }

  void setSelected() {
    sessionCubit.selectionChanged(this);
    emit(state.copyWith(isSelected: true));
  }

  void toggleEditMode(){
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  static SessionStepCubit getCubit(
    SessionStep sessionStep,
    SessionCubit sessionCubit,) {
    return sessionStep is SessionBlock
        ? SessionBlockCubit(sessionStep as SessionBlock, sessionCubit,)
        : SessionIntervalCubit(sessionStep as SessionInterval, sessionCubit,);
  }


  SessionStep getObject(int sequenceIndex, SessionBlock? parent);
}
