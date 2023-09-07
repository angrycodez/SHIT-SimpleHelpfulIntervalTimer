import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

import '../../data/models/models.dart';
import '../widgets/session_step_widget.dart';

class SessionPage extends StatelessWidget {
  final SessionCubit session;
  const SessionPage(this.session, {super.key});

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
    return BlocProvider.value(
      value: session,
      child: BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
        return state is SessionStateLoaded
            ? Scaffold(
                appBar: StandardComponents.getAppBar(context, state.name),
                body: ListView.builder(
                  itemCount: state.steps.length,
                  itemBuilder: (context, index) {
                    SessionStepCubit step = state.steps[index];
                    return SessionStepWidget(
                      step,
                      key: Key(step.state.id),
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }
}
