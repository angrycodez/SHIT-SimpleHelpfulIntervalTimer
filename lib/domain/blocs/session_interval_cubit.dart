import 'package:simple_interval_timer/data/models/models.dart';

import 'blocs.dart';

class SessionIntervalCubit extends SessionStepCubit {
  SessionIntervalCubit(
    SessionInterval sessionInterval,
    SessionCubit sessionCubit,
  ) : super(
          sessionInterval,
          sessionCubit,
        );
}
