import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/presentation/widgets/duration_info.dart';
import 'package:simple_interval_timer/presentation/widgets/scrolling_text.dart';

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
        borderColor: isSelected ? MyColors.cardEditBorderColor : null,
      ),
      child: SessionIntervalInfoWidget(
        intervalCubit,
        key: Key("${interval.id}_info"),
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
        Expanded(flex: 2, child: _intervalNameInfo(context)),
        DurationInfo(interval.duration),
        //Expanded(flex: 1, child: IntervalTypeInfo(interval.isPause)),
      ],
    );
  }

  Widget _intervalNameInfo(BuildContext context) {
    return Row(
      children: [
        intervalCubit.state.isPause
            ? MyIcons.pauseIcon
            : MyIcons.sessionIntervalIcon,
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Expanded(
          child: ScrollingText(
            intervalCubit.state.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(width: Layout.defaultHorizontalSpace),
      ],
    );
  }
}
