import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/converter.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/presentation/widgets/duration_text_field.dart';

import '../../domain/blocs/blocs.dart';

class SessionIntervalWidget extends StatelessWidget {
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalWidget(this.intervalCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionIntervalState interval = intervalCubit.state;
    bool isSelected = intervalCubit.state.isSelected;
    return Container(
      padding: Layout.cardPadding,
      decoration: MyDecoration.cardDecoration(
        context,
        color: interval.color,
        borderColor: isSelected
            ? MyColors.cardEditBorderColor
            : null,
      ),
      child: SessionIntervalInfoWidget(
              intervalCubit,
              key: Key(interval.id + "_info"),
            ),
    );
  }
}

class SessionIntervalInfoWidget extends StatelessWidget {
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalInfoWidget(this.intervalCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionIntervalState interval = intervalCubit.state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(interval.name ?? ""),
        Text(TypeConverter.durationToString(interval.duration)),
        Text(interval.isPause ? "Pause" : "Work"),
        if (interval.isPause) ...[MyIcons.pauseIcon] else ...[MyIcons.workIcon]
      ],
    );
  }
}
