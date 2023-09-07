import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/session_overview_cubit.dart';
import 'package:simple_interval_timer/presentation/widgets/session_widget.dart';

import '../../data/models/models.dart';

class SessionOverviewPage extends StatelessWidget {
  final List<Session> sessions;
  const SessionOverviewPage(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionOverviewCubit(sessions),
      child: BlocBuilder<SessionOverviewCubit, SessionOverviewState>(
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            children: [ListView.builder(
              shrinkWrap: true,
              itemCount: state.sessions.length,
              itemBuilder: (context, index) =>
                  SessionWidget(state.sessions[index]),
            ),Center(
              child: IconButton(
                onPressed: () =>
                    context.read<SessionOverviewCubit>().createNewSession(),
                icon: MyIcons.createNewIcon,
              ),
            ),],
          ),
        ),
      ),
    );
  }
}
