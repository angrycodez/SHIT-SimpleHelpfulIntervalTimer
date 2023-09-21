part of 'session_cubit.dart';

class SessionState extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<SessionStepCubit> steps;
  final SessionStepCubit? selectedStep;
  bool get hasSelectedStep => selectedStep != null;

  final Sound? endSound;

  final Duration duration;


  final bool hasChanges;

  const SessionState({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    this.duration = Duration.zero,
    this.selectedStep,
    this.hasChanges = false,
    this.endSound,
  }) : super();

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        steps,
        duration,
        selectedStep,
        hasChanges,
    endSound,
      ];

  SessionState withSelectedStep(SessionStepCubit? selectedStep) {
    return SessionState(
      id: id,
      name: name,
      description: description,
      steps: steps,
      duration: duration,
      selectedStep: selectedStep,
      hasChanges: hasChanges,
      endSound: endSound,
    );
  }

  SessionState copyWithEndSound(Sound? endSound) {
    return SessionState(
      id: id,
      name: name,
      description: description,
      steps: steps,
      duration: duration,
      selectedStep: selectedStep,
      hasChanges: hasChanges,
      endSound: endSound,
    );
  }
  SessionState copyWith({
    String? id,
    String? name,
    String? description,
    Duration? duration,
    List<SessionStepCubit>? steps,
  }) {
    return SessionState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      duration: duration ?? this.duration,
      selectedStep: selectedStep,
      hasChanges: true,
      endSound: endSound,
    );
  }
}
