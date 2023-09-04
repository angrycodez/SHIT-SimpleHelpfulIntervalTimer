import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import '../../domain/blocs/blocs.dart';

class SessionIntervalWidget extends StatelessWidget {
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalWidget(this.intervalCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionInterval interval = intervalCubit.state.sessionStep as SessionInterval;
    bool isEditMode = intervalCubit.state.isEditMode;
    return Container(
      margin: Layout.cardMargin,
      padding: Layout.cardPadding,
      decoration: MyDecoration.cardDecoration(
        context,
        color: Colors.lightBlueAccent,
        showBorder: isEditMode,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(interval.name ?? ""),
          Text(interval.duration.toString()),
          Text(interval.isPause ? "Pause" : "Work"),
          if (interval.isPause) ...[
            MyIcons.pauseIcon
          ] else ...[
            MyIcons.workIcon
          ]
        ],
      ),
    );
  }
}
