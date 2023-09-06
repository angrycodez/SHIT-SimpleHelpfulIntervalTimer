part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object?> get props => [];
}

class SessionStateLoaded extends SessionState {
  final String id;
  final String name;
  final List<SessionStepCubit> steps;
  Duration get duration => steps.fold(
      Duration.zero,
      (previousValue, element) => Duration(
          seconds: previousValue.inSeconds + element.state.duration.inSeconds));
  final bool hasChanges;

  SessionStateLoaded.fromSession(
    Session session,
    SessionCubit sessionCubit, ) : this(
          id: session.id,
          name: session.name,
          steps: session.steps
              .map((e) => SessionStepCubit.getCubit(
                    e,
                    sessionCubit,
                  ))
              .toList(),
        );

  const SessionStateLoaded({
    required this.id,
    required this.name,
    required this.steps,
    this.hasChanges = false,
  }) : super();

  @override
  List<Object> get props => [
        id,
        name,
        steps,
        hasChanges,
      ];

  SessionStateLoaded copyWith({
    String? id,
    String? name,
    List<SessionStepCubit>? steps,
    bool? hasChanges,
  }) {
    return SessionStateLoaded(
      id: id ?? this.id,
      name: name ?? this.name,
      steps: steps ?? this.steps,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }
}
