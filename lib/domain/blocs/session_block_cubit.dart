import 'package:simple_interval_timer/data/models/models.dart';
import 'blocs.dart';

class SessionBlockCubit extends SessionStepCubit {
  SessionBlockCubit(
    SessionBlock sessionBlock,
    SessionCubit sessionCubit,
  ) : super(
          sessionBlock,
          sessionCubit,
        );
  void addStep() {}
  void addBlock() {}
}
