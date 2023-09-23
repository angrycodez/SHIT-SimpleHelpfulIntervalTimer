import 'dart:async';

import 'package:simple_interval_timer/data/models/models.dart';
import 'package:uuid/uuid.dart';
import '../../core/helper/constants.dart';
import 'blocs.dart';

part 'session_block_state.dart';

class SessionBlockCubit extends SessionStepCubit {
  @override
  SessionBlockState get state => super.state as SessionBlockState;

  late List<SessionStepCubit> _children;
  List<StreamSubscription>? _listener;

  SessionBlockCubit(SessionBlock sessionBlock) : super.block(sessionBlock) {
    updateChildren(sessionBlock.children
        .map((step) => SessionStepCubit.getCubit(step))
        .toList());
  }

  @override
  Future<void> close() async {
    await _disposeStepListener();
    return super.close();
  }

  Future updateChildren(List<SessionStepCubit> children) async {
    await _disposeStepListener();
    _children = children;
    emit(state.copyWith(children: List.of(_children)));
    await _registerStepListener();
    updateDuration();
  }

  Future _disposeStepListener() async{
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
    for (var child in _children) {
      if(child.durationUpdatedStreamController.hasListener){
      }
      _listener!.add(await child.subscribeDurationUpdates(_onDurationChanged));
    }
  }

  void _onDurationChanged(Duration duration) {
    updateDuration();
  }

  void updateDuration() {
    emit(state.copyWith(duration: _computeDuration()));
    durationUpdatedStreamController.add(state.duration);
  }

  @override
  void selectionChanged(SessionStepCubit? editStep) {
    super.selectionChanged(editStep);
    for(var child in _children){
      child.selectionChanged(editStep);
    }
  }

  Duration _computeDuration([int? repetitions]) {
    return Duration(
        seconds: _children.fold(
                0,
                (previousValue, step) =>
                    previousValue + step.state.duration.inSeconds) *
            (repetitions ?? state.repetitions));
  }

  void addInterval() {
    var interval = SessionInterval(
        id: const Uuid().v4(),
        name: "",
        sequenceIndex: state.children.length,
        duration: Duration.zero,
        isPause: false,
        color: defaultIntervalColor,
    );
    var cubit = SessionIntervalCubit(interval);
    _children.add(cubit);
    updateChildren(_children);
  }

  void addBlock() {
    var block = SessionBlock(
        id: const Uuid().v4(),
        name: "",
        sequenceIndex: state.children.length,
        repetitions: 1,
        children: const []);
    var cubit = SessionBlockCubit(block);
    _children.add(cubit);
    updateChildren(_children);
  }

  @override
  SessionBlock getObject(int sequenceIndex, SessionBlock? parent) {
    List<SessionStep> children = List.empty(growable: true);

    // create children from cubits
    for (int i = 0; i < _children.length; i++) {
      SessionStepCubit child = _children[i];
      if (child is SessionBlockCubit) {
        children.add(child.getObject(i, null));
      } else if (child is SessionIntervalCubit) {
        children.add(child.getObject(i, null));
      }
    }

    // create object
    SessionBlock object = SessionBlock(
      id: state.id,
      sequenceIndex: sequenceIndex,
      name: state.name,
      repetitions: state.repetitions,
      children: children,
      parentStep: parent,
    );

    // reference parent
    for (int i = 0; i < object.children.length; i++) {
      SessionStep child = object.children[i];
      if (child is SessionBlock) {
        child = child.copyWith(parentStep: object);
      } else if (child is SessionInterval) {
        child = child.copyWith(parentStep: object);
      }
      object.children[i] = child;
    }

    return object;
  }

  void setRepetitions(int repetitions) {
    emit(state.copyWith(repetitions: repetitions));
    updateDuration();
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }
}
