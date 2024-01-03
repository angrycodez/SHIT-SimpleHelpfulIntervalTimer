import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

import '../../domain/blocs/blocs.dart';
import '../pages/pages.dart';
import 'widets.dart';

class SessionIntervalEditControlsWidget extends StatelessWidget {
  final SessionIntervalCubit sessionInterval;

  const SessionIntervalEditControlsWidget(this.sessionInterval, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    return BlocProvider.value(
      value: sessionInterval,
      child: BlocBuilder<SessionIntervalCubit, SessionStepState>(
        builder: (context, state) => EditControlsRow(
          actions: [
            IconButton(
                onPressed: () => _delete(context), icon: MyIcons.deleteIcon),
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(SessionIntervalEditPage.getRoute(sessionInterval)),
              icon: MyIcons.editIcon,
            ),
            IconButton(
              onPressed: sessionInterval.canMoveDown(sessionCubit)
                  ? () => sessionInterval.moveDown(sessionCubit)
                  : null,
              icon: MyIcons.moveDownIcon,
            ),
            IconButton(
              onPressed: sessionInterval.canMoveUp(sessionCubit)
                  ? () => sessionInterval.moveUp(sessionCubit)
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
        context, "Are you sure?", "Do you want to delete the interval?")) {
      return;
    }
    sessionInterval.delete(sessionCubit);
  }
}
