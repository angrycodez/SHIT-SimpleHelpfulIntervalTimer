part of 'session_block_cubit.dart';

class SessionBlockState extends SessionStepState {
  final List<SessionStepCubit> children;
  final int repetitions;
  final bool hasDirectChanges;
  final bool isEditMode;

  @override
  bool get hasChanges =>
      hasDirectChanges || children.any((child) => child.hasChanges);

  const SessionBlockState({
    required super.id,
    required super.name,
    super.duration = Duration.zero,
    required this.repetitions,
    required this.children,
    super.isSelected = false,
    this.isEditMode = false,
    this.hasDirectChanges = false,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        children,
        repetitions,
        isEditMode,
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
    return SessionBlockState(
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
