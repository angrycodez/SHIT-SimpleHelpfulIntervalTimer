import 'dart:math';

import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

part 'session_interval_state.dart';

class SessionIntervalCubit extends SessionStepCubit {
  @override
  SessionIntervalState get state => super.state as SessionIntervalState;

  SessionIntervalCubit(
    SessionInterval sessionInterval,
    SessionCubit sessionCubit, {
    void Function(SessionStepCubit, {SessionStepCubit? referenceStep})? moveUp,
    void Function(SessionStepCubit, {SessionStepCubit? referenceStep})?
        moveDown,
    bool Function(SessionStepCubit, {SessionStepCubit? referenceStep})?
        canMoveUp,
    bool Function(SessionStepCubit, {SessionStepCubit? referenceStep})?
        canMoveDown,
    void Function(SessionStepCubit)? delete,
  }) : super(
          sessionInterval,
          sessionCubit,
          moveUp: moveUp ?? (a, {SessionStepCubit? referenceStep}) {},
          moveDown: moveDown ?? (a, {SessionStepCubit? referenceStep}) {},
          canMoveUp:
              canMoveUp ?? (a, {SessionStepCubit? referenceStep}) => false,
          canMoveDown:
              canMoveDown ?? (a, {SessionStepCubit? referenceStep}) => false,
          delete: delete ?? (a) {},
        );
}
