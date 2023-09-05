part of 'session_interval_cubit.dart';

class SessionIntervalState extends SessionStepState {
  @override
  final Duration duration;
  final bool isPause;
  final Sound? startSound;
  final Sound? endSound;

  SessionIntervalState.fromInterval(
    SessionInterval sessionInterval, {
    bool isEditMode = false,
  }) : this(
          id: sessionInterval.id,
          name: sessionInterval.name,
          duration: sessionInterval.duration,
          isPause: sessionInterval.isPause,
          startSound: sessionInterval.startSound,
          endSound: sessionInterval.endSound,
          isEditMode: isEditMode,
        );

  const SessionIntervalState({
    required super.id,
    super.name,
    required this.duration,
    required this.isPause,
    this.startSound,
    this.endSound,
    super.isEditMode = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        duration,
        isPause,
        startSound,
        endSound,
      ];

  @override
  SessionIntervalState copyWith({
    String? id,
    String? name,
    Duration? duration,
    bool? isPause,
    Sound? startSound,
    Sound? endSound,
    bool? isEditMode,
  }) {
    return SessionIntervalState(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      isPause: isPause ?? this.isPause,
      startSound: startSound ?? this.startSound,
      endSound: endSound ?? this.endSound,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  SessionInterval getObject(int sequenceIndex, SessionBlock? parent) {
    return SessionInterval(
      id: id,
      name: name,
      parentStep: parent,
      sequenceIndex: sequenceIndex,
      duration: duration,
      isPause: isPause,
      startSound: startSound,
      endSound: endSound,
    );
  }
}