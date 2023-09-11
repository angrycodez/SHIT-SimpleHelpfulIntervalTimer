import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:simple_interval_timer/presentation/widgets/session_block_edit_controls_widget.dart';
import 'package:simple_interval_timer/presentation/widgets/session_interval_edit_controls_widget.dart';

import '../../data/models/models.dart';
import '../widgets/session_edit_controls_widget.dart';
import '../widgets/session_step_widget.dart';

class SessionPage extends StatelessWidget {
  final SessionCubit sessionCubit;
  const SessionPage(this.sessionCubit, {super.key});

  static MaterialPageRoute getRoute(SessionCubit session, {Key? key}) {
    return MaterialPageRoute(
      builder: (context) => SessionPage(
        session,
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          if(sessionCubit.loadedState.hasChanges) {
            await sessionCubit.storeSession(context
              .read<SessionDatabaseCubit>()
              .sessionRepository);
          }
          return true;
        },
      child: BlocProvider.value(
        value: sessionCubit,
        child: BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
          return state is SessionStateLoaded
              ? Scaffold(
                  appBar: StandardComponents.getAppBar(context, state.name),
                  body: Container(
                    margin: Layout.cardMargin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: state.name,
                          maxLength: 64,
                          decoration: const InputDecoration(
                            helperText: "Name",
                          ),
                          onChanged: (newValue) => sessionCubit.setName(newValue),
                        ),
                        TextFormField(
                          initialValue: state.description,
                          maxLength: 1024,
                          decoration: const InputDecoration(
                            helperText: 'Description',
                          ),
                          onChanged: (newValue) =>
                              sessionCubit.setDescription(newValue),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.steps.length,
                            itemBuilder: (context, index) {
                              SessionStepCubit step = state.steps[index];
                              return SessionStepWidget(
                                step,
                                key: Key(step.state.id),
                              );
                            },
                          ),
                        ),
                        if (state.selectedStep is SessionIntervalCubit) ...[
                          SessionIntervalEditControlsWidget(
                            state.selectedStep as SessionIntervalCubit,
                            key: Key(
                                state.selectedStep!.state.id + "_edit_controls"),
                          ),
                        ] else if (state.selectedStep is SessionBlockCubit) ...[
                          SessionBlockEditControlsWidget(
                            state.selectedStep as SessionBlockCubit,
                            key: Key(
                                state.selectedStep!.state.id + "_edit_controls"),
                          ),
                        ] else ...[
                          SessionEditControlsWidget(
                            context.read<SessionCubit>(),
                            key: Key(state.id + "_edit_controls"),
                          ),
                        ]
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }),
      ),
    );
  }
}
