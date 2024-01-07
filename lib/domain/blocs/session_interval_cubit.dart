import 'dart:ui';

import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_interval_state.dart';

class SessionIntervalCubit extends SessionStepCubit {
  @override
  SessionIntervalState get state => super.state as SessionIntervalState;

  SessionIntervalCubit(SessionInterval sessionInterval)
      : super.interval(sessionInterval) {
    _updateDuration();
  }

  void _updateDuration([Duration? duration]){
    duration ??= state.duration;
    emit(state.copyWith(duration: duration));
    durationUpdatedStreamController.add(state.duration);
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  @override
  SessionInterval getObject(int sequenceIndex, SessionBlock? parent) {
    return SessionInterval(
      id: state.id,
      name: state.name,
      parentStep: parent,
      sequenceIndex: sequenceIndex,
      duration: state.duration,
      isPause: state.isPause,
      startSound: state.startSound,
      startCommand: state.startCommand,
      color: state.color,
    );
  }

  setIsPause(bool? isPause) {
    emit(state.copyWith(isPause: isPause));
  }

  void setDuration(Duration duration) {
    _updateDuration(duration);
  }

  void setStartSound(Sound? sound) {
    emit(state.copyWithStartSound(sound));
  }

  void setStartCommand(String? command) {
    emit(state.copyWith(startCommand: command));
  }

  void setColor(Color color) {
    emit(state.copyWith(color: color));
  }
}
