import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_interval_state.dart';

class SessionIntervalCubit extends SessionStepCubit {
  @override
  SessionIntervalState get state => super.state as SessionIntervalState;

  SessionIntervalCubit(
    SessionInterval sessionInterval,
    SessionCubit sessionCubit, ) : super(
          sessionInterval,
          sessionCubit,
        );

  @override
  SessionInterval getObject(int sequenceIndex, SessionBlock? parent) {
    return SessionInterval(
      id: state.id,
      name: state.name,
      parentStep: parent,
      sequenceIndex: sequenceIndex,
      duration: state.duration,
      isPause: state.isPause,
      startSound: state.startSound,
      endSound: state.endSound,
    );
  }
}
