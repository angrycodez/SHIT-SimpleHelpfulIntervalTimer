import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/datasources/local/daos/daos.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/data/repositories/session_repository.dart';
import 'package:uuid/uuid.dart';

import 'blocs.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  late final StreamController<String?> _editModeChangedStreamController;
  Stream<String?> get editModeChangedStream =>
      _editModeChangedStreamController.stream;

  SessionCubit(Session session) : super(const SessionState()) {
    _editModeChangedStreamController = StreamController<String?>.broadcast();
    emit(SessionStateLoaded.fromSession(
      session,
      this,
    ));
    loadedState.steps.forEach((element) {
      element.durationUpdatedStream.listen((newDuration) {
        emit(loadedState.copyWith(duration: loadedState.computeDuration()));
      });
    });
  }

  SessionStateLoaded get loadedState {
    assert(state is SessionStateLoaded);
    return state as SessionStateLoaded;
  }

  void selectionChanged(SessionStepCubit? step) {
    _editModeChangedStreamController.sink.add(step?.state.id);
    if (state is SessionStateLoaded) {
      emit((state as SessionStateLoaded).withSelectedStep(step));
    }
  }

  StepSearchResult? _findStep(
      SessionStepCubit step, SessionBlockCubit? parent) {
    if (this.state is! SessionStateLoaded) {
      return null;
    }
    SessionStateLoaded state = loadedState;
    var steps = parent == null ? state.steps : parent.state.children;
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
      return StepSearchResult(stepIndex, parent, steps);
    }
    return null;
  }

  List<SessionStepCubit> _moveStepInList(
    List<SessionStepCubit> steps,
    int index,
    Direction direction,
  ) {
    assert(0 <= index && index < steps.length);
    if (index == 0 && direction == Direction.up ||
        index == steps.length - 1 && direction == Direction.down) {
      return steps;
    }
    steps = List.of(steps);
    SessionStepCubit step = steps[index];
    int newIndex = index + StepDirection.byEnum(direction);
    var stepAtNewIndexPosition = steps[newIndex];
    steps.removeAt(index);

    if (stepAtNewIndexPosition is SessionBlockCubit) {
      SessionBlockCubit block = stepAtNewIndexPosition;
      var blockSteps = List.of(block.state.children);
      switch (direction) {
        case Direction.up:
          blockSteps.add(step);
          break;
        case Direction.down:
          blockSteps.insert(0, step);
          break;
      }
      block.emit(block.state.copyWith(children: blockSteps));
    } else {
      steps.insert(newIndex, step);
    }
    return steps;
  }

  void _moveStepToParent(
    StepSearchResult stepLocation,
    Direction direction,
  ) {
    assert(stepLocation.parent != null);
    assert(this.state is SessionStateLoaded);

    // remove step from current parent
    var locationSteps = List.of(stepLocation.steps);
    var step = locationSteps[stepLocation.index];
    locationSteps.removeAt(stepLocation.index);
    SessionBlockCubit parent = stepLocation.parent!;
    parent.emit(parent.state.copyWith(children: locationSteps));

    // find the steps that contain the parent and insert the step there
    var parentLocation = _findStep(stepLocation.parent!, null)!;

    int newIndex = parentLocation.index;
    if (direction == Direction.down) {
      newIndex += 1;
    }
    locationSteps = List.of(parentLocation.steps);
    locationSteps.insert(newIndex, step);

    // emit the new state for the parent
    if (parentLocation.parent == null) {
      emit((state as SessionStateLoaded).copyWith(steps: locationSteps));
      return;
    } else {
      SessionBlockCubit parent = parentLocation.parent!;
      parent.emit(parent.state.copyWith(children: locationSteps));
      return;
    }
  }

  bool _isStepAtListEnd(
      int index, List<SessionStepCubit> steps, Direction direction) {
    if (index == 0 && direction == Direction.up ||
        index == steps.length - 1 && direction == Direction.down) {
      return true;
    }
    return false;
  }

  void _moveChild(SessionStepCubit movingStep, Direction direction) {
    if (!_canMoveChild(movingStep, direction)) {
      return;
    }
    SessionStateLoaded state = this.state as SessionStateLoaded;

    var stepLocation = _findStep(movingStep, null);
    assert(stepLocation != null);
    stepLocation = stepLocation!;

    if (stepLocation.parent == null) {
      // move the step in first level (Session.steps)
      emit(
        state.copyWith(
          steps: _moveStepInList(
            stepLocation.steps,
            stepLocation.index,
            direction,
          ),
        ),
      );
      return;
    } else {
      // step is found in some block
      if (!_isStepAtListEnd(
          stepLocation.index, stepLocation.steps, direction)) {
        // step can be moved around within this block
        SessionBlockCubit parent = stepLocation.parent!;
        parent.emit(
          parent.state.copyWith(
            children: _moveStepInList(
              stepLocation.steps,
              stepLocation.index,
              direction,
            ),
          ),
        );
        return;
      } else {
        // step needs to be moved to parent block
        _moveStepToParent(stepLocation, direction);
      }
    }
  }

  bool _canMoveChild(SessionStepCubit movingStep, Direction direction) {
    var search = _findStep(movingStep, null);
    return search != null &&
        (!_isStepAtListEnd(search.index, search.steps, direction) ||
            search.parent != null);
  }

  void moveUpChild(SessionStepCubit movingStep) {
    _moveChild(movingStep, Direction.up);
  }

  bool canMoveUpChild(SessionStepCubit movingStep) {
    return _canMoveChild(movingStep, Direction.up);
  }

  void moveDownChild(SessionStepCubit movingStep) {
    _moveChild(movingStep, Direction.down);
  }

  bool canMoveDownChild(SessionStepCubit movingStep) {
    return _canMoveChild(movingStep, Direction.down);
  }

  void delete(SessionStepCubit step) {
    var stepLocation = _findStep(step, null);
    assert(stepLocation != null);
    stepLocation = stepLocation!;
    var steps = List.of(stepLocation.steps);
    steps.removeAt(stepLocation.index);

    if (stepLocation.parent == null) {
      emit((state as SessionStateLoaded).copyWith(steps: steps));
    } else {
      SessionBlockCubit parent = stepLocation.parent!;
      parent.emit(parent.state.copyWith(children: steps));
    }
  }

  void addInterval() {
    var state = this.state as SessionStateLoaded;
    var interval = SessionInterval(
      id: const Uuid().v4(),
      name: "",
      sequenceIndex: state.steps.length,
      duration: const Duration(seconds: 1),
      isPause: false,
    );
    var cubit = SessionIntervalCubit(interval, this);
    var steps = List.of(state.steps);
    steps.add(cubit);
    emit(state.copyWith(steps: steps));
  }

  void addBlock() {
    var state = this.state as SessionStateLoaded;
    var block = SessionBlock(
      id: const Uuid().v4(),
      name: "",
      sequenceIndex: state.steps.length,
      repetitions: 1,
      children: [],
    );
    var cubit = SessionBlockCubit(block, this);
    var steps = List.of(state.steps);
    steps.add(cubit);
    emit(state.copyWith(steps: steps));
  }

  void setName(String name) {
    emit(loadedState.copyWith(name: name));
  }

  void setDescription(String description) {
    emit(loadedState.copyWith(description: description));
  }

  Session getObject() {
    SessionStateLoaded state = loadedState;
    List<SessionStep> steps = List.empty(growable: true);
    for (int i = 0; i < state.steps.length; i++) {
      steps.add(state.steps[i].getObject(i, null));
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

enum Direction { up, down }

class StepDirection {
  static const int up = -1;
  static const int down = 1;

  static int byEnum(Direction direction) {
    switch (direction) {
      case Direction.up:
        return up;
      case Direction.down:
        return down;
    }
  }
}

class StepSearchResult {
  final int index;
  final SessionBlockCubit? parent;
  final List<SessionStepCubit> steps;
  const StepSearchResult(this.index, this.parent, this.steps);
}
