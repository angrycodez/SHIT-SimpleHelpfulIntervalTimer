import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

import '../../domain/blocs/blocs.dart';
import 'widets.dart';

class SessionBlockEditControlsWidget extends StatelessWidget {
  final SessionBlockCubit sessionBlock;

  const SessionBlockEditControlsWidget(this.sessionBlock, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    return BlocProvider.value(
      value: sessionBlock,
      child: BlocBuilder<SessionBlockCubit, SessionStepState>(
        builder: (context, state) => EditControlsRow(
          actions: [
            IconButton(
                onPressed: () => _delete(context), icon: MyIcons.deleteIcon),
            IconButton(
                onPressed: () => sessionBlock.addInterval(),
                icon: MyIcons.createNewIntervalIcon),
            IconButton(
                onPressed: () => sessionBlock.addBlock(),
                icon: MyIcons.createNewBlockIcon),
            IconButton(
              onPressed: sessionBlock.canMoveDown(sessionCubit)
                  ? () => sessionBlock.moveDown(sessionCubit)
                  : null,
              icon: MyIcons.moveDownIcon,
            ),
            IconButton(
              onPressed: sessionBlock.canMoveUp(sessionCubit)
                  ? () => sessionBlock.moveUp(sessionCubit)
                  : null,
              icon: MyIcons.moveUpIcon,
            ),
          ],
        ),
      ),
    );
  }

  Future _delete(BuildContext context) async {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    if (!await ConfirmationDialog.askForConfirmation(
        context, "Are you sure?", "Do you want to delete the block?")) {
      return;
    }
    sessionBlock.delete(sessionCubit);
  }
}
