import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:simple_interval_timer/main.dart';
import 'package:simple_interval_timer/presentation/pages/session_page.dart';
import 'package:simple_interval_timer/presentation/widgets/my_scaffold.dart';
import 'package:simple_interval_timer/presentation/widgets/session_widget.dart';

class SessionOverviewPage extends StatelessWidget {
  const SessionOverviewPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => SessionOverviewPage(key: key));
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar:
          StandardComponents.getAppBar(context, SimpleIntervalTimerApp.title),
      body: BlocProvider(
        create: (_) =>
            SessionOverviewCubit(context.read<SessionDatabaseCubit>()),
        child: BlocBuilder<SessionOverviewCubit, SessionOverviewState>(
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.sessions.length,
                  itemBuilder: (context, index) =>
                      SessionWidget(state.sessions[index]),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      indent: Layout.defaultHorizontalSpace,
                      endIndent: Layout.defaultHorizontalSpace,
                      height: Layout.defaultVerticalSpace,
                    );
                  },
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      var sessionCubit = context
                          .read<SessionOverviewCubit>()
                          .createNewSession(context);
                      if (sessionCubit != null) {
                        Navigator.of(context)
                            .push(SessionPage.getRoute(sessionCubit));
                      }
                    },
                    icon: MyIcons.createNewSessionIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
