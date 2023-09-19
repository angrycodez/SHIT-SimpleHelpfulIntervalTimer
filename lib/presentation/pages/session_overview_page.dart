import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/session_overview_cubit.dart';
import 'package:simple_interval_timer/main.dart';
import 'package:simple_interval_timer/presentation/pages/session_page.dart';
import 'package:simple_interval_timer/presentation/widgets/my_scaffold.dart';
import 'package:simple_interval_timer/presentation/widgets/session_widget.dart';

import '../../data/models/models.dart';

class SessionOverviewPage extends StatelessWidget {
  final List<Session> sessions;
  const SessionOverviewPage(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: StandardComponents.getAppBar(context, SimpleIntervalTimerApp.title),
      body: BlocProvider(
        create: (_) => SessionOverviewCubit(sessions),
        child: BlocBuilder<SessionOverviewCubit, SessionOverviewState>(
          builder: (context, state) => state is SessionOverviewStateInitialized
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.sessions.length,
                        itemBuilder: (context, index) =>
                            SessionWidget(state.sessions[index]),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            var sessionCubit = context
                              .read<SessionOverviewCubit>()
                              .createNewSession();
                            if(sessionCubit != null){
                              Navigator.of(context).push(SessionPage.getRoute(sessionCubit));
                            }
                          },
                          icon: MyIcons.createNewSessionIcon,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
