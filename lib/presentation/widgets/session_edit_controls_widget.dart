import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/presentation/widgets/confirmation_dialog.dart';
import 'package:simple_interval_timer/presentation/widgets/edit_controls_row.dart';

import '../../domain/blocs/blocs.dart';
import '../../domain/blocs/timer_cubit.dart';
import '../pages/pages.dart';

class SessionEditControlsWidget extends StatelessWidget {
  final SessionCubit session;

  const SessionEditControlsWidget(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    return EditControlsRow(
      actions: [
        IconButton(
            onPressed: () => _deleteSession(context), icon: MyIcons.deleteIcon),
        IconButton(
          onPressed: () => session.addInterval(context),
          icon: MyIcons.createNewIntervalIcon,
        ),
        IconButton(
          onPressed: () => session.addBlock(),
          icon: MyIcons.createNewBlockIcon,
        ),
        IconButton(
          onPressed: session.state.steps.isNotEmpty
              ? () async {
                  var timerCubit = context.read<TimerCubit>();
                  var sessionCubit = context.read<SessionCubit>();
                  await sessionCubit.storeSession(context.read<SessionDatabaseCubit>().sessionRepository);
                  timerCubit.init(sessionCubit.getObject());
                  timerCubit.start();
                  if(context.mounted) {
                    Navigator.of(context).push(TimerPage.getRoute());
                  }
                }
              : null,
          icon: MyIcons.startSessionIcon,
        ),
      ],
    );
  }

  Future _deleteSession(BuildContext context) async {
    if (!await ConfirmationDialog.askForConfirmation(
        context, "Are you sure?", "Do you want to delete the session?")) {
      return;
    }
    if (context.mounted) {
      Navigator.of(context).pop();
      session.deleteSession();
    }
  }
}
