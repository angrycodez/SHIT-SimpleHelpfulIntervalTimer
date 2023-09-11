import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

import '../../domain/blocs/blocs.dart';

class SessionIntervalEditControlsWidget extends StatelessWidget {
  SessionIntervalCubit sessionInterval;

  SessionIntervalEditControlsWidget(this.sessionInterval, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sessionInterval,
      child: BlocBuilder<SessionIntervalCubit, SessionStepState>(
        builder: (context, state) => Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => sessionInterval.delete(), icon: MyIcons.deleteIcon,),
              IconButton(onPressed: () => sessionInterval.toggleEditMode(), icon: sessionInterval.state.isEditMode ? MyIcons.editOffIcon : MyIcons.editOnIcon,),
              IconButton(onPressed: sessionInterval.canMoveDown() ? () => sessionInterval.moveDown() : null, icon: MyIcons.moveDownIcon,),
              IconButton(onPressed: sessionInterval.canMoveUp()? () => sessionInterval.moveUp() : null, icon: MyIcons.moveUpIcon,),
            ],
          ),
        ),
      ),
    );
  }
}
