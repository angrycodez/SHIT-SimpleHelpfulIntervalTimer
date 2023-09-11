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
    SessionIntervalState interval = intervalCubit.state;
    bool isSelected = intervalCubit.state.isSelected;
    return Container(
      margin: Layout.cardMargin,
      padding: Layout.cardPadding,
      decoration: MyDecoration.cardDecoration(
        context,
        color: Colors.lightBlueAccent,
        borderColor: isSelected
            ? MyColors.cardEditBorderColor
            : MyColors.cardBorderColor,
      ),
      child: interval.isEditMode
          ? SessionIntervalEditWidget(
              intervalCubit,
              key: Key(interval.id + "_edit"),
            )
          : SessionIntervalInfoWidget(
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
        Text(interval.duration.toString()),
        Text(interval.isPause ? "Pause" : "Work"),
        if (interval.isPause) ...[MyIcons.pauseIcon] else ...[MyIcons.workIcon]
      ],
    );
  }
}

class SessionIntervalEditWidget extends StatelessWidget {
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalEditWidget(this.intervalCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionIntervalState interval = intervalCubit.state;
    bool isSelected = intervalCubit.state.isSelected;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: interval.name ?? "",
            decoration: const InputDecoration(
              helperText: "Name",
            ),
            onChanged: (newValue) => intervalCubit.setName(newValue),
          ),
        ),
        Text(interval.duration.toString()),
        Row(
          children: [
            Checkbox(
                value: interval.isPause,
                onChanged: (newValue) => intervalCubit.setIsPause(newValue)),
            Text("Pause"),
            if (interval.isPause) ...[
              MyIcons.pauseIcon
            ] else ...[
              MyIcons.workIcon
            ]
          ],
        ),
      ],
    );
  }
}
