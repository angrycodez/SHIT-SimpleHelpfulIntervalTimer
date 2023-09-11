import 'package:simple_interval_timer/data/models/models.dart';
import 'package:uuid/uuid.dart';
import 'blocs.dart';

part 'session_block_state.dart';

class SessionBlockCubit extends SessionStepCubit {
  @override
  SessionBlockState get state => super.state as SessionBlockState;

  SessionBlockCubit(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit,
  ) : super(
          sessionBlock,
          sessionCubit,
        ) {
    state.children.forEach((element) {
      element.stream.listen((event) {
        emit(state.copyWith(duration: state.computeDuration()));
      });
    });
  }

  void addInterval() {
    var interval = SessionInterval(
        id: Uuid().v4(),
        sequenceIndex: state.children.length,
        duration: Duration(seconds: 1),
        isPause: false);
    var cubit = SessionIntervalCubit(interval, sessionCubit);
    var children = List.of(state.children);
    children.add(cubit);
    emit(state.copyWith(children: children));
  }

  void addBlock() {
    var block = SessionBlock(
        id: Uuid().v4(),
        sequenceIndex: state.children.length,
        repetitions: 1,
        children: []);
    var cubit = SessionBlockCubit(block, sessionCubit);
    var children = List.of(state.children);
    children.add(cubit);
    emit(state.copyWith(children: children));
  }

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

  void setRepetitions(int repititions) {
    emit(state.copyWith(repetitions: repititions));
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }
}
