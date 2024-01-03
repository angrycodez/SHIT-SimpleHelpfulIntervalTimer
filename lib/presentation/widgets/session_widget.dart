import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/timer_page.dart';
import 'package:simple_interval_timer/presentation/widgets/duration_info.dart';

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
        builder: (context, session) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            SessionPage.getRoute(
              sessionCubit,
              key: Key(session.id),
            ),
          ),
          child: Container(
            margin: Layout.cardMargin,
            padding: Layout.cardPadding,
            decoration: MyDecoration.cardDecoration(context, color: MyColors.cardBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(session.name, style: Theme.of(context).textTheme.labelMedium,)),
                DurationInfo(session.duration),
                IconButton(
                  onPressed: () {
                    var timerCubit = context.read<TimerCubit>();
                    var sessionCubit = context.read<SessionCubit>();
                    timerCubit.init(sessionCubit.getObject());
                    timerCubit.start();
                    Navigator.of(context).push(TimerPage.getRoute());
                  },
                  icon: MyIcons.startSessionIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
