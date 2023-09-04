import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

import '../../data/models/models.dart';
import '../widgets/session_step_widget.dart';

class SessionPage extends StatelessWidget {
  final Session session;
  const SessionPage(this.session, {super.key});

  static MaterialPageRoute getRoute(Session session, {Key? key}) {
    return MaterialPageRoute(
      builder: (context) => SessionPage(
        session,
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardComponents.getAppBar(context, session.name),
      body: BlocProvider(
        create: (_) => SessionCubit(session),
        child: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) => ListView.builder(
            itemCount: state.session.steps.length,
            itemBuilder: (context, index) {
              SessionStep step = state.session.steps[index];
              return SessionStepWidget(
                SessionStepCubit.getCubit(
                  step,
                  context.read<SessionCubit>(),
                ),
                key: Key(step.id),
              );
            },
          ),
        ),
      ),
    );
  }
}
