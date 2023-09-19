part of 'session_step_cubit.dart';

class SessionStepState extends Equatable {
  final String id;
  final String name;

  final bool isSelected;
  final bool isEditMode;
  final bool hasChanges;

  final Duration duration;

  SessionStepState.fromStep(
    SessionStep sessionStep,
  {
    bool isEditMode = false,
  }): this(id: sessionStep.id, name: sessionStep.name, isSelected: isEditMode,);

  const SessionStepState({required this.id, required this.name, this.duration = Duration.zero, this.isSelected=false, this.isEditMode=false, this.hasChanges=false});

  @override
  List<Object?> get props => [id, name, duration, isSelected, isEditMode, hasChanges,];


  SessionStepState copyWith({
    String? id,
    String? name,
    Duration? duration,
    bool? isSelected,
    bool? isEditMode,
  }) {
    return SessionStepState(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      isSelected: isSelected ?? this.isSelected,
      isEditMode: isEditMode ?? this.isEditMode,
      hasChanges: true,
    );
  }
}
