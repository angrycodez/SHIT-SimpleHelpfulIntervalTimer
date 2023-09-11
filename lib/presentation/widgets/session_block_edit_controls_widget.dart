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
    return BlocProvider.value(
      value: sessionBlock,
      child: BlocBuilder<SessionBlockCubit, SessionStepState>(
        builder: (context, state) => Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => sessionBlock.delete(), icon: MyIcons.deleteIcon,),
              IconButton(onPressed: () => sessionBlock.addInterval(), icon: MyIcons.createNewIntervalIcon,),
              IconButton(onPressed: () => sessionBlock.addBlock(), icon: MyIcons.createNewBlockIcon,),
              IconButton(onPressed: () => sessionBlock.toggleEditMode(), icon: sessionBlock.state.isEditMode ? MyIcons.editOffIcon : MyIcons.editOnIcon,),
              IconButton(onPressed: sessionBlock.canMoveDown() ? () => sessionBlock.moveDown() : null, icon: MyIcons.moveDownIcon,),
              IconButton(onPressed: sessionBlock.canMoveUp()? () => sessionBlock.moveUp() : null, icon: MyIcons.moveUpIcon,),
            ],
          ),
        ),
      ),
    );
  }
}
