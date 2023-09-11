part of 'session_step_cubit.dart';

class SessionStepState extends Equatable {
  final String id;
  final String? name;

  final bool isSelected;
  final bool isEditMode;
  final bool hasChanges;

  Duration get duration => Duration.zero;

  SessionStepState.fromStep(
    SessionStep sessionStep,
  {
    bool isEditMode = false,
  }): this(id: sessionStep.id, name: sessionStep.name, isSelected: isEditMode,);

  const SessionStepState({required this.id, this.name, this.isSelected=false, this.isEditMode=false, this.hasChanges=false});

  @override
  List<Object?> get props => [id, name, isSelected, isEditMode, hasChanges,];


  SessionStepState copyWith({
    String? id,
    String? name,
    bool? isSelected,
    bool? isEditMode,
  }) {
    return SessionStepState(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      isEditMode: isEditMode ?? this.isEditMode,
      hasChanges: true,
    );
  }
}
