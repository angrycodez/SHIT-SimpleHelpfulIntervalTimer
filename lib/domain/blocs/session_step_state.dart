part of 'session_step_cubit.dart';

class SessionStepState extends Equatable {
  final String id;
  final String? name;

  final bool isEditMode;

  Duration get duration => Duration.zero;

  SessionStepState.fromStep(
    SessionStep sessionStep,
  {
    bool isEditMode = false,
  }): this(id: sessionStep.id, name: sessionStep.name, isEditMode: isEditMode,);

  const SessionStepState({required this.id, this.name, this.isEditMode=false,});

  @override
  List<Object?> get props => [id, name, isEditMode];


  SessionStepState copyWith({
    String? id,
    String? name,
    bool? isEditMode,
  }) {
    return SessionStepState(
      id: id ?? this.id,
      name: name ?? this.name,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
