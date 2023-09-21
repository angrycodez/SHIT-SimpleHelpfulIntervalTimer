import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/data/repositories/session_repository.dart';
import 'package:uuid/uuid.dart';

import 'blocs.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  late List<SessionStepCubit> _steps;
  List<StreamSubscription>? _listener;

  final Future Function(String) _deleteSession;

  SessionCubit(Session session, this._deleteSession)
      : super(SessionState(
          id: session.id,
          name: session.name,
          description: session.description,
          steps: List.empty(),
        )) {
    _updateSteps(
        session.steps.map((step) => SessionStepCubit.getCubit(step)).toList());
  }

  @override
  Future<void> close() async {
    await _disposeStepListener();
    return super.close();
  }

  Future _updateSteps(List<SessionStepCubit> steps) async {
    await _disposeStepListener();
    _steps = steps;
    emit(state.copyWith(steps: List.of(_steps)));
    await _registerStepListener();
    updateDuration();
  }

  Future _disposeStepListener() async {
    if (_listener == null) {
      return;
    }
    for (var sub in _listener!) {
      await sub.cancel();
    }
    _listener = null;
  }

  Future _registerStepListener() async {
    _listener ??= List<StreamSubscription>.empty(growable: true);
    for (var step in _steps) {
      //_listener!.add(await step.subscribeSelectionUpdates(_onSelectionChanged));
      _listener!.add(await step.subscribeDurationUpdates(_onDurationChanged));
    }
  }

  void selectionChanged(SessionStepCubit? selected) {
    for (var step in _steps) {
      step.selectionChanged(selected);
    }
    emit(state.withSelectedStep(selected));
  }

  void _onDurationChanged(Duration duration) {
    updateDuration();
  }

  void updateDuration() {
    emit(state.copyWith(duration: _computeDuration()));
  }

  Duration _computeDuration() => _steps.fold(
      Duration.zero,
      (previousValue, step) => Duration(
          seconds: previousValue.inSeconds + step.state.duration.inSeconds));

  _StepSearchResult? _findStep(
    SessionStepCubit step,
    SessionBlockCubit? parent,
  ) {
    var steps = parent == null ? _steps : parent.state.children;
    int stepIndex = steps.indexOf(step);

    if (stepIndex == -1) {
      // step is not in current list; search in sub_blocks
      for (var parent in steps.whereType<SessionBlockCubit>()) {
        var result = _findStep(step, parent);
        if (result != null) {
          return result;
        }
      }
    } else {
      // step is in current list
      return _StepSearchResult(stepIndex, parent, steps);
    }
    return null;
  }

  Future<List<SessionStepCubit>> _moveStepInList(
    List<SessionStepCubit> steps,
    int index,
    _Direction direction,
  ) async {
    assert(0 <= index && index < steps.length);
    if (index == 0 && direction == _Direction.up ||
        index == steps.length - 1 && direction == _Direction.down) {
      return steps;
    }
    steps = List.of(steps);
    SessionStepCubit step = steps[index];
    int newIndex = index + _StepDirection.byEnum(direction);
    var stepAtNewIndexPosition = steps[newIndex];
    steps.removeAt(index);

    if (stepAtNewIndexPosition is SessionBlockCubit) {
      SessionBlockCubit block = stepAtNewIndexPosition;
      var blockSteps = List.of(block.state.children);
      switch (direction) {
        case _Direction.up:
          blockSteps.add(step);
          break;
        case _Direction.down:
          blockSteps.insert(0, step);
          break;
      }
      await block.updateChildren(blockSteps);
    } else {
      steps.insert(newIndex, step);
    }
    return steps;
  }

  Future _moveStepToParent(
    _StepSearchResult stepLocation,
    _Direction direction,
  ) async {
    assert(stepLocation.parent != null);

    // remove step from current parent
    var locationSteps = List.of(stepLocation.steps);
    var step = locationSteps[stepLocation.index];
    locationSteps.removeAt(stepLocation.index);
    SessionBlockCubit parent = stepLocation.parent!;
    await parent.updateChildren(locationSteps);

    // find the steps that contain the parent and insert the step there
    var parentLocation = _findStep(stepLocation.parent!, null)!;

    int newIndex = parentLocation.index;
    if (direction == _Direction.down) {
      newIndex += 1;
    }
    locationSteps = List.of(parentLocation.steps);
    locationSteps.insert(newIndex, step);

    // emit the new state for the parent
    if (parentLocation.parent == null) {
      await _updateSteps(locationSteps);
      return;
    } else {
      SessionBlockCubit parent = parentLocation.parent!;
      await parent.updateChildren(locationSteps);
      return;
    }
  }

  bool _isStepAtListEnd(
      int index, List<SessionStepCubit> steps, _Direction direction) {
    if (index == 0 && direction == _Direction.up ||
        index == steps.length - 1 && direction == _Direction.down) {
      return true;
    }
    return false;
  }

  Future _moveChild(SessionStepCubit movingStep, _Direction direction) async {
    if (!_canMoveChild(movingStep, direction)) {
      return;
    }

    var stepLocation = _findStep(movingStep, null);
    assert(stepLocation != null);
    stepLocation = stepLocation!;

    if (stepLocation.parent == null) {
      // move the step in first level (Session.steps)
      await _updateSteps(
        await _moveStepInList(
          stepLocation.steps,
          stepLocation.index,
          direction,
        ),
      );
      return;
    } else {
      // step is found in some block
      if (!_isStepAtListEnd(
          stepLocation.index, stepLocation.steps, direction)) {
        // step can be moved around within this block
        SessionBlockCubit parent = stepLocation.parent!;
        await parent.updateChildren(
          await _moveStepInList(
            stepLocation.steps,
            stepLocation.index,
            direction,
          ),
        );
        return;
      } else {
        // step needs to be moved to parent block
        _moveStepToParent(stepLocation, direction);
      }
    }
  }

  bool _canMoveChild(SessionStepCubit movingStep, _Direction direction) {
    var search = _findStep(movingStep, null);
    return search != null &&
        (!_isStepAtListEnd(search.index, search.steps, direction) ||
            search.parent != null);
  }

  void moveUpChild(SessionStepCubit movingStep) {
    _moveChild(movingStep, _Direction.up);
  }

  bool canMoveUpChild(SessionStepCubit movingStep) {
    return _canMoveChild(movingStep, _Direction.up);
  }

  void moveDownChild(SessionStepCubit movingStep) {
    _moveChild(movingStep, _Direction.down);
  }

  bool canMoveDownChild(SessionStepCubit movingStep) {
    return _canMoveChild(movingStep, _Direction.down);
  }

  Future deleteStep(SessionStepCubit step) async {
    var stepLocation = _findStep(step, null);
    assert(stepLocation != null);
    stepLocation = stepLocation!;
    var steps = List.of(stepLocation.steps);
    steps.removeAt(stepLocation.index);

    if (stepLocation.parent == null) {
      await _updateSteps(steps);
    } else {
      SessionBlockCubit parent = stepLocation.parent!;
      await parent.updateChildren(steps);
    }
  }

  Future deleteSession()async{
    await _deleteSession(state.id);
  }

  Future addInterval(BuildContext context) async {
    var settings = context.read<SettingsCubit>();
    var interval = SessionInterval(
      id: const Uuid().v4(),
      name: "",
      sequenceIndex: state.steps.length,
      duration: const Duration(seconds: 1),
      isPause: false,
      startSound: settings.state.defaultIntervalStartSound,
      endSound: settings.state.defaultIntervalEndSound,
      color: defaultIntervalColor,
    );
    var cubit = SessionIntervalCubit(interval);
    _steps.add(cubit);
    await _updateSteps(_steps);
  }

  Future addBlock() async {
    var block = SessionBlock(
      id: const Uuid().v4(),
      name: "",
      sequenceIndex: state.steps.length,
      repetitions: 1,
      children: [],
    );
    var cubit = SessionBlockCubit(block);
    _steps.add(cubit);
    await _updateSteps(_steps);
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }
  void setEndSound(Sound? endSound) {
    emit(state.copyWithEndSound(endSound));
  }

  void deselectAll(){
    selectionChanged(null);
  }

  Session getObject() {
    List<SessionStep> steps = List.empty(growable: true);
    for (int i = 0; i < _steps.length; i++) {
      steps.add(_steps[i].getObject(i, null));
    }
    return Session(
      state.id,
      state.name,
      state.description,
      steps,
    );
  }

  List<SessionInterval> getIntervalSequence() {
    return getObject().intervalSequence;
  }

  Future storeSession(SessionRepository sessionRepository) async {
    await sessionRepository.storeSession(getObject());
  }
}

// Helper Classes

enum _Direction { up, down }

class _StepDirection {
  static const int up = -1;
  static const int down = 1;

  static int byEnum(_Direction direction) {
    switch (direction) {
      case _Direction.up:
        return up;
      case _Direction.down:
        return down;
    }
  }
}

class _StepSearchResult {
  final int index;
  final SessionBlockCubit? parent;
  final List<SessionStepCubit> steps;
  const _StepSearchResult(this.index, this.parent, this.steps);
}
