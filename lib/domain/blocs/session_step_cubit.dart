import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_step_state.dart';

abstract class SessionStepCubit extends Cubit<SessionStepState> {

  @protected
  StreamController<Duration> durationUpdatedStreamController =
      StreamController();
  Stream<Duration> get durationUpdatedStream =>
      durationUpdatedStreamController.stream.asBroadcastStream();

  SessionStepCubit.interval(
    SessionInterval sessionInterval,
  ) : super(SessionIntervalState(
          id: sessionInterval.id,
          name: sessionInterval.name,
          duration: sessionInterval.duration,
          isPause: sessionInterval.isPause,
          startSound: sessionInterval.startSound,
          endSound: sessionInterval.endSound,
          isSelected: false,
    color: sessionInterval.color,
        ));
  SessionStepCubit.block(
    SessionBlock sessionBlock,
  ) : super(SessionBlockState(
          id: sessionBlock.id,
          name: sessionBlock.name,
          repetitions: sessionBlock.repetitions,
          children: List.empty(),
          isSelected: false,
          isEditMode: false,
        ));
  bool get hasChanges => state.hasChanges;

  Future<StreamSubscription> subscribeDurationUpdates(
      Function(Duration) onUpdate) async {
    if (durationUpdatedStreamController.hasListener) {
      await durationUpdatedStreamController.close();
    }
    durationUpdatedStreamController = StreamController();
    return durationUpdatedStreamController.stream.listen(onUpdate);
  }

  @override
  Future<void> close() async {
    await durationUpdatedStreamController.close();
    return super.close();
  }

  // if referenceStep is null, use movingStep for reference
  void moveUp(SessionCubit sessionCubit) => sessionCubit.moveUpChild(this);
  void moveDown(SessionCubit sessionCubit) => sessionCubit.moveDownChild(this);

  bool canMoveUp(SessionCubit sessionCubit) =>
      sessionCubit.canMoveUpChild(this);
  bool canMoveDown(SessionCubit sessionCubit) =>
      sessionCubit.canMoveDownChild(this);

  void delete(SessionCubit sessionCubit) => sessionCubit.deleteStep(this);

  void selectionChanged(SessionStepCubit? editStep) {
    if (editStep?.state.id != state.id) {
      emit(state.copyWith(isSelected: false));
    }
  }

  void setSelected(SessionCubit sessionCubit) {
    sessionCubit.selectionChanged(this);
    emit(state.copyWith(isSelected: true));
  }

  static SessionStepCubit getCubit(SessionStep sessionStep) {
    return sessionStep is SessionBlock
        ? SessionBlockCubit(sessionStep as SessionBlock)
        : SessionIntervalCubit(sessionStep as SessionInterval);
  }

  SessionStep getObject(int sequenceIndex, SessionBlock? parent);
}
