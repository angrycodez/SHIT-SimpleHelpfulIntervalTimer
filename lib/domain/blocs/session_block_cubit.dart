import 'package:simple_interval_timer/data/models/models.dart';
import 'blocs.dart';

part 'session_block_state.dart';

class SessionBlockCubit extends SessionStepCubit {
  @override
  SessionBlockState get state => super.state as SessionBlockState;

  SessionBlockCubit(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit, {
    void Function(SessionStepCubit, {SessionStepCubit? referenceStep})? moveUp,
    void Function(SessionStepCubit, {SessionStepCubit? referenceStep})? moveDown,
    bool Function(SessionStepCubit, {SessionStepCubit? referenceStep})? canMoveUp,
    bool Function(SessionStepCubit, {SessionStepCubit? referenceStep})? canMoveDown,
    void Function(SessionStepCubit)? delete,
  }) : super(
          sessionBlock,
          sessionCubit,
          moveUp: moveUp ?? (a,{SessionStepCubit? referenceStep}){},
          moveDown: moveDown ?? (a,{SessionStepCubit? referenceStep}) {},
          canMoveUp: canMoveUp ?? (a,{SessionStepCubit? referenceStep})=>false,
          canMoveDown: canMoveDown ?? (a,{SessionStepCubit? referenceStep}) => false,
          delete: delete ?? (a){},
        );
  void addStep() {}
  void addBlock() {}
}
