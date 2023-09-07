import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import '../../domain/blocs/blocs.dart';
import '../pages/session_page.dart';

class SessionWidget extends StatelessWidget {
  final SessionCubit sessionCubit;
  const SessionWidget(this.sessionCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sessionCubit,
      child: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, session) => session is SessionStateLoaded ? GestureDetector(
          onTap: () => Navigator.of(context).push(
            SessionPage.getRoute(
              sessionCubit,
              key: Key(session.id),
            ),
          ),
          child: Container(
            margin: Layout.cardMargin,
            padding: Layout.cardPadding,
            decoration: MyDecoration.cardDecoration(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(session.name),
                Text(session.duration.toString()),
                IconButton(
                  onPressed: () {},
                  icon: MyIcons.startSessionIcon,
                ),
              ],
            ),
          ),
        ):const SizedBox.shrink(),
      ),
    );
  }
}
