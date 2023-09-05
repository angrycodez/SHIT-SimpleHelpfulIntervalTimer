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
          sessionCubit: sessionCubit,
          isEditMode: isEditMode,
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
        .map((e) {
          if (e is SessionBlock) {
            return SessionBlockCubit(e, sessionCubit);
          } else if (e is SessionInterval) {
            return SessionIntervalCubit(e, sessionCubit);
          }
          return null;
        })
        .where((element) => element != null)
        .map((e) => e!)
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
  }) {
    return SessionBlockState.fromCopy(
      id: id ?? this.id,
      name: name ?? this.name,
      children: children ?? this.children,
      repetitions: repetitions ?? this.repetitions,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  SessionBlock getObject(int sequenceIndex, SessionBlock? parent) {
    List<SessionStep> children = List.empty(growable: true);

    // create children from cubits
    for (int i = 0; i < this.children.length; i++) {
      SessionStepCubit child = this.children[i];
      if (child is SessionBlockCubit) {
        children.add(child.state.getObject(i, null));
      } else if (child is SessionIntervalCubit) {
        children.add(child.state.getObject(i, null));
      }
    }

    // create object
    SessionBlock object = SessionBlock(
      id: id,
      sequenceIndex: sequenceIndex,
      name: name,
      repetitions: repetitions,
      children: children,
      parentStep: parent,
    );

    // reference parent
    for (int i = 0; i < object.children.length; i++) {
      SessionStep child = object.children[i];
      if (child is SessionBlock) {
        child = child.copyWith(parentStep: object);
      } else if (child is SessionInterval) {
        child = child.copyWith(parentStep: object);
      }
      object.children[i] = child;
    }

    return object;
  }
}
