part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object?> get props => [];
}

class SessionStateLoaded extends SessionState {
  final String id;
  final String name;
  final String description;
  final List<SessionStepCubit> steps;
  final SessionStepCubit? selectedStep;
  bool get hasSelectedStep => selectedStep != null;
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
          description: session.description,
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
    required this.description,
    required this.steps,
    this.selectedStep,
    this.hasChanges = false,
  }) : super();

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        steps,
        selectedStep,
        hasChanges,
      ];

  SessionStateLoaded withSelectedStep(SessionStepCubit? selectedStep) {
    return SessionStateLoaded(
      id: id,
      name: name,
      description: description,
      steps: steps,
      selectedStep: selectedStep,
      hasChanges: hasChanges,
    );
  }
  SessionStateLoaded copyWith({
    String? id,
    String? name,
    String? description,
    List<SessionStepCubit>? steps,
  }) {
    return SessionStateLoaded(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      selectedStep: selectedStep,
      hasChanges: true,
    );
  }
}
