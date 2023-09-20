part of 'session_block_cubit.dart';

class SessionBlockState extends SessionStepState {
  late final List<SessionStepCubit> children;
  final int repetitions;
  final bool hasDirectChanges;
  final bool isEditMode;

  @override
  bool get hasChanges => hasDirectChanges
      || children.any((child) => child.hasChanges);

  Duration computeDuration([int? repetitions]){
    return Duration(seconds: children.fold(
        0,
            (previousValue, element) =>
            previousValue +
                (element.state is SessionBlockState
                    ? (element.state as SessionBlockState).computeDuration().inSeconds
                    : element.state.duration.inSeconds))
        * (repetitions ?? this.repetitions),
    );
  }

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
    required super.name,
    required super.duration,
    required this.repetitions,
    required this.children,
    super.isSelected = false,
    this.isEditMode = false,
    this.hasDirectChanges = true
  });

  SessionBlockState({
    required super.id,
    required super.name,
    super.duration = Duration.zero,
    required this.repetitions,
    required List<SessionStep> children,
    required SessionCubit sessionCubit,
    super.isSelected = false,
    this.isEditMode = false,
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
    Duration? duration,
    List<SessionStepCubit>? children,
    int? repetitions,
    bool? isSelected,
    bool? isEditMode,
  }) {
    return SessionBlockState.fromCopy(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      children: children ?? this.children,
      repetitions: repetitions ?? this.repetitions,
      isSelected: isSelected ?? this.isSelected,
      isEditMode: isEditMode ?? this.isEditMode,
      hasDirectChanges: true,
    );
  }
}
