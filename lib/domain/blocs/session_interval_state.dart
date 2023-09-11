part of 'session_interval_cubit.dart';

class SessionIntervalState extends SessionStepState {

  final bool isPause;
  final Sound? startSound;
  final Sound? endSound;

  SessionIntervalState.fromInterval(SessionInterval sessionInterval) : this(
          id: sessionInterval.id,
          name: sessionInterval.name,
          duration: sessionInterval.duration,
          isPause: sessionInterval.isPause,
          startSound: sessionInterval.startSound,
          endSound: sessionInterval.endSound,
          isSelected: false,
          isEditMode: false,
        );

  const SessionIntervalState({
    required super.id,
    super.name,
    required super.duration,
    required this.isPause,
    this.startSound,
    this.endSound,
    super.isSelected = false,
    super.isEditMode = false,
    super.hasChanges = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
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
    bool? isSelected,
    bool? isEditMode,
  }) {
    return SessionIntervalState(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      isPause: isPause ?? this.isPause,
      startSound: startSound ?? this.startSound,
      endSound: endSound ?? this.endSound,
      isSelected: isSelected ?? this.isSelected,
      isEditMode: isEditMode ?? this.isEditMode,
      hasChanges: true,
    );
  }

}
