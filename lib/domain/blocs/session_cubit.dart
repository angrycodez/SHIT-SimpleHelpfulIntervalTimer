import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  late final StreamController<String?> _editModeChangedStreamController;
  Stream<String?> get editModeChangedStream => _editModeChangedStreamController.stream;

  SessionCubit(Session session) : super(const SessionState()) {
    _editModeChangedStreamController = StreamController<String?>.broadcast();
    emit(SessionStateLoaded.fromSession(
      session,
      this,
    ));
  }

  void editModeChanged(String? stepId) {
    _editModeChangedStreamController.sink.add(stepId);
  }


  StepSearchResult? _findStep(SessionStepCubit step, SessionBlockCubit? parent){
    if(this.state is! SessionStateLoaded){
      return null;
    }
    SessionStateLoaded state = this.state as SessionStateLoaded;
    var steps = parent == null
        ? state.steps
        : parent.state.children;
    int stepIndex = steps.indexOf(step);

    if(stepIndex == -1){
      // step is not in current list; search in sub_blocks
      for(var parent in steps.whereType<SessionBlockCubit>()){
        var result = _findStep(step, parent);
        if(result != null){
          return result;
        }
      }
    }else{
      // step is in current list
      return StepSearchResult(stepIndex, parent);
    }
    return null;
  }

  void _moveStep(SessionStepCubit step, int direction){
    assert(direction == 1 || direction == -1);

    // check, if step is in children of session
    // if not, find the sessionBlock, containing the step
    var stepLocation = _findStep(step, null);
    if(stepLocation == null){
      return;
    }
    SessionStateLoaded state = this.state as SessionStateLoaded;
    void Function() updateSteps;
    // get the list of steps, where the step is included
    List<SessionStepCubit> steps;
    if(stepLocation.parent == null){
      steps = List.of(state.steps);
      updateSteps = () => emit(state.copyWith(steps: steps));
    }else{
      steps = List.of(stepLocation.parent!.state.children);
      updateSteps = () => stepLocation.parent!.emit(stepLocation.parent!.state.copyWith(children: steps));
    }

    // if the step is not at the edge (0 < index < steps.length), just move it within the steps
    // else, find the parent where the step needs to be inserted and insert it to the end/beginning

  }

  void moveUpChild (SessionStepCubit movingStep) {
    if(!canMoveUpChild(movingStep)){
      return;
    }
    SessionStateLoaded state = this.state as SessionStateLoaded;
    var steps = List.of(state.steps);

    var stepLocation = _findStep(movingStep, null);
    if(stepLocation == null){
      return;
    }
    if(stepLocation.parent == null){
      var steps = List.of(state.steps);
      // move the step in first level
      if(stepLocation.index == 0){
        return;
      }else if(stepLocation.index > 0){
        steps.removeAt(stepLocation.index);
        int newIndex = stepLocation.index - 1;
        if(steps[newIndex] is SessionBlockCubit){
          SessionBlockCubit block = steps[newIndex] as SessionBlockCubit;
          var stepsTmp = block.state.children;
          stepsTmp.add(movingStep);
          block.emit(block.state.copyWith(children: stepsTmp));
        }else {
          steps.insert(stepLocation.index - 1, movingStep);
        }
        emit(state.copyWith(steps: steps));
        return;
      }
    }else{
      var steps = List.of(stepLocation.parent!.state.children);
      // step is found in some block
      if(stepLocation.index > 0){
        steps.removeAt(stepLocation.index);
        int newIndex = stepLocation.index - 1;
        if(steps[newIndex] is SessionBlockCubit){
          SessionBlockCubit block = steps[newIndex] as SessionBlockCubit;
          var stepsTmp = block.state.children;
          stepsTmp.add(movingStep);
          block.emit(block.state.copyWith(children: stepsTmp));
        }else {
          steps.insert(stepLocation.index - 1, movingStep);
        }
        stepLocation.parent!.emit(stepLocation.parent!.state.copyWith(children: steps));
        return;
      }else{
        steps.removeAt(stepLocation.index);
        stepLocation.parent!.emit(stepLocation.parent!.state.copyWith(children: steps));
        var parentLocation = _findStep(stepLocation.parent!, null);
        if(parentLocation!.parent == null){
          steps = List.of(state.steps);
          steps.insert(parentLocation.index, movingStep);
          emit(state.copyWith(steps: steps));
          return;
        }else{
          steps = List.of(parentLocation.parent!.state.children);
          steps.insert(parentLocation.index, movingStep);
          parentLocation.parent!.emit(parentLocation.parent!.state.copyWith(children: steps));
          return;
        }
      }
    }
  }

  bool canMoveUpChild (SessionStepCubit movingStep) {
    var search = _findStep(movingStep, null);
    return search != null && (search.index > 0 || search.parent != null);
  }

  Session? getObject() {
    if (this.state is! SessionStateLoaded) {
      return null;
    }
    SessionStateLoaded state = this.state as SessionStateLoaded;
    List<SessionStep> steps = List.empty(growable: true);
    for (int i = 0; i < state.steps.length; i++) {
      steps.add(state.steps[i].getObject(i, null));
    }
    return Session(
      state.id,
      state.name,
      steps,
    );
  }
}


class StepSearchResult{
  final int index;
  final SessionBlockCubit? parent;
  const StepSearchResult(this.index, this.parent);
}