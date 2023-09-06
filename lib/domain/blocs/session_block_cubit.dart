import 'package:simple_interval_timer/data/models/models.dart';
import 'blocs.dart';

part 'session_block_state.dart';

class SessionBlockCubit extends SessionStepCubit {
  @override
  SessionBlockState get state => super.state as SessionBlockState;

  SessionBlockCubit(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit, ) : super(
          sessionBlock,
          sessionCubit,
        ) {}
  void addStep() {}
  void addBlock() {}

  @override
  SessionBlock getObject(int sequenceIndex, SessionBlock? parent) {
    List<SessionStep> children = List.empty(growable: true);

    // create children from cubits
    for (int i = 0; i < state.children.length; i++) {
      SessionStepCubit child = state.children[i];
      if (child is SessionBlockCubit) {
        children.add(child.getObject(i, null));
      } else if (child is SessionIntervalCubit) {
        children.add(child.getObject(i, null));
      }
    }

    // create object
    SessionBlock object = SessionBlock(
      id: state.id,
      sequenceIndex: sequenceIndex,
      name: state.name,
      repetitions: state.repetitions,
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
