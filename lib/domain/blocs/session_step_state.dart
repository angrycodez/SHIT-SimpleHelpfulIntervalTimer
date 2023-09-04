part of 'session_step_cubit.dart';

class SessionStepState extends Equatable {
  final SessionStep sessionStep;
  final SessionCubit sessionCubit;
  final bool isEditMode;
  String get id => sessionStep.id;
  String? get name => sessionStep.name;

  const SessionStepState({
    required this.sessionStep,
    required this.sessionCubit,
    this.isEditMode = false,
  });

  @override
  List<Object> get props => [sessionStep, isEditMode];

  SessionStepState copyWith({
    SessionStep? sessionStep,
    bool? isEditMode,
  }) {
    return SessionStepState(
      sessionStep: sessionStep ?? this.sessionStep,
      sessionCubit: sessionCubit,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
