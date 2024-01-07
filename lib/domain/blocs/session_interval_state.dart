part of 'session_interval_cubit.dart';

class SessionIntervalState extends SessionStepState {
  final bool isPause;
  final Sound? startSound;
  final String? startCommand;
  final Color color;

  SessionIntervalState.fromInterval(SessionInterval sessionInterval)
      : this(
          id: sessionInterval.id,
          name: sessionInterval.name,
          duration: sessionInterval.duration,
          isPause: sessionInterval.isPause,
          startSound: sessionInterval.startSound,
          startCommand: sessionInterval.startCommand,
          isSelected: false,
          color: sessionInterval.color,
        );

  const SessionIntervalState({
    required super.id,
    required super.name,
    required super.duration,
    required this.isPause,
    this.startSound,
    this.startCommand,
    super.isSelected = false,
    super.hasChanges = false,
    required this.color,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        isPause,
        startSound,
        startCommand,
        color,
      ];

  SessionIntervalState copyWithStartSound(Sound? startSound) {
    return SessionIntervalState(
      id: id,
      name: name,
      duration: duration,
      isPause: isPause,
      startSound: startSound,
      startCommand: startCommand,
      isSelected: isSelected,
      color: color,
    );
  }

  @override
  SessionIntervalState copyWith({
    String? id,
    String? name,
    Duration? duration,
    bool? isPause,
    Sound? startSound,
    String? startCommand,
    bool? isSelected,
    Color? color,
  }) {
    return SessionIntervalState(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      isPause: isPause ?? this.isPause,
      startSound: startSound ?? this.startSound,
      startCommand: startCommand ?? this.startCommand,
      isSelected: isSelected ?? this.isSelected,
      hasChanges: true,
      color: color ?? this.color,
    );
  }
}
