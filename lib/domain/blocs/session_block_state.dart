part of 'session_block_cubit.dart';

class SessionBlockState extends SessionStepState {
  late final List<SessionStepCubit> children;
  final int repetitions;
  final bool hasDirectChanges;

  @override
  bool get hasChanges => hasDirectChanges
      || children.any((child) => child.hasChanges);

  @override
  Duration get duration => children.fold(
      Duration.zero,
      (previousValue, element) => Duration(
          seconds: (previousValue.inSeconds + element.state.duration.inSeconds)
              .toInt() * repetitions));

  SessionBlockState.fromBlock(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit,
  ) : this(
          id: sessionBlock.id,
          name: sessionBlock.name,
          repetitions: sessionBlock.repetitions,
          children: sessionBlock.children,
          isSelected: false,
          isEditMode: false,
          sessionCubit: sessionCubit,
        );

  SessionBlockState.fromCopy({
    required super.id,
    super.name,
    required this.repetitions,
    required this.children,
    super.isSelected = false,
    super.isEditMode = false,
    this.hasDirectChanges = true
  });

  SessionBlockState({
    required super.id,
    super.name,
    required this.repetitions,
    required List<SessionStep> children,
    required SessionCubit sessionCubit,
    super.isSelected = false,
    super.isEditMode = false,
    this.hasDirectChanges = false,
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
    bool? isSelected,
    bool? isEditMode,
  }) {
    return SessionBlockState.fromCopy(
      id: id ?? this.id,
      name: name ?? this.name,
      children: children ?? this.children,
      repetitions: repetitions ?? this.repetitions,
      isSelected: isSelected ?? this.isSelected,
      isEditMode: isEditMode ?? this.isEditMode,
      hasDirectChanges: true,
    );
  }
}
