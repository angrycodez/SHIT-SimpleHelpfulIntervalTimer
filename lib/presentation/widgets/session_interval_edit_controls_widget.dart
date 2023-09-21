import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

import '../../domain/blocs/blocs.dart';
import '../pages/pages.dart';

class SessionIntervalEditControlsWidget extends StatelessWidget {
  SessionIntervalCubit sessionInterval;

  SessionIntervalEditControlsWidget(this.sessionInterval, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    return BlocProvider.value(
      value: sessionInterval,
      child: BlocBuilder<SessionIntervalCubit, SessionStepState>(
        builder: (context, state) => Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => sessionInterval.delete(sessionCubit), icon: MyIcons.deleteIcon,),
              IconButton(onPressed: () => Navigator.of(context).push(SessionIntervalEditPage.getRoute(sessionInterval)), icon: MyIcons.editOnIcon,),
              IconButton(onPressed: sessionInterval.canMoveDown(sessionCubit) ? () => sessionInterval.moveDown(sessionCubit) : null, icon: MyIcons.moveDownIcon,),
              IconButton(onPressed: sessionInterval.canMoveUp(sessionCubit) ? () => sessionInterval.moveUp(sessionCubit) : null, icon: MyIcons.moveUpIcon,),
            ],
          ),
        ),
      ),
    );
  }
}
