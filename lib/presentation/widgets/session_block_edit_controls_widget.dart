import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import '../../domain/blocs/blocs.dart';

class SessionBlockEditControlsWidget extends StatelessWidget {
  SessionBlockCubit sessionBlock;

  SessionBlockEditControlsWidget(this.sessionBlock, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    return BlocProvider.value(
      value: sessionBlock,
      child: BlocBuilder<SessionBlockCubit, SessionStepState>(
        builder: (context, state) => Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => sessionBlock.delete(sessionCubit), icon: MyIcons.deleteIcon,),
              IconButton(onPressed: () => sessionBlock.addInterval(), icon: MyIcons.createNewIntervalIcon,),
              IconButton(onPressed: () => sessionBlock.addBlock(), icon: MyIcons.createNewBlockIcon,),
              IconButton(onPressed: () => sessionBlock.toggleEditMode(), icon: sessionBlock.state.isEditMode ? MyIcons.editOffIcon : MyIcons.editOnIcon,),
              IconButton(onPressed: sessionBlock.canMoveDown(sessionCubit) ? () => sessionBlock.moveDown(sessionCubit) : null, icon: MyIcons.moveDownIcon,),
              IconButton(onPressed: sessionBlock.canMoveUp(sessionCubit)? () => sessionBlock.moveUp(sessionCubit) : null, icon: MyIcons.moveUpIcon,),
            ],
          ),
        ),
      ),
    );
  }
}
