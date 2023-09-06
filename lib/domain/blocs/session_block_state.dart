part of 'session_block_cubit.dart';

class SessionBlockState extends SessionStepState {
  late final List<SessionStepCubit> children;
  final int repetitions;

  @override
  Duration get duration => children.fold(
      Duration.zero,
      (previousValue, element) => Duration(
          seconds: (previousValue.inSeconds + element.state.duration.inSeconds)
              .toInt()));

  SessionBlockState.fromBlock(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit, {
    bool isEditMode = false,
  }) : this(
          id: sessionBlock.id,
          name: sessionBlock.name,
          repetitions: sessionBlock.repetitions,
          children: sessionBlock.children,
          isEditMode: isEditMode,
          sessionCubit: sessionCubit,
        );

  SessionBlockState.fromCopy({
    required super.id,
    super.name,
    required this.repetitions,
    required this.children,
    super.isEditMode = false,

  });

  SessionBlockState({
    required super.id,
    super.name,
    required this.repetitions,
    required List<SessionStep> children,
    required SessionCubit sessionCubit,
    super.isEditMode = false,

  }) {
    this.children = children
        .map((e) => SessionStepCubit.getCubit(
              e,
              sessionCubit,
            ))
        .toList();
  }

  @override
  List<Object?> get props => [
        ...super.props,
        children,
        repetitions,
      ];

  @override
  SessionBlockState copyWith({
    String? id,
    String? name,
    List<SessionStepCubit>? children,
    int? repetitions,
    bool? isEditMode,
void Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep})?
moveUp,
bool Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep})?
canMoveUp,
void Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep})?
moveDown,
bool Function(SessionStepCubit movingStep, {SessionStepCubit? referenceStep})?
canMoveDown,

void Function(SessionStepCubit deletedStep)? delete,
  }) {
    return SessionBlockState.fromCopy(
      id: id ?? this.id,
      name: name ?? this.name,
      children: children ?? this.children,
      repetitions: repetitions ?? this.repetitions,
      isEditMode: isEditMode ?? this.isEditMode,

    );
  }
}
