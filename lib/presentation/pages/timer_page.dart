import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/converter.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';

class TimerPage extends StatelessWidget {
  TimerPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => TimerPage(key: key));
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    TimerCubit timerCubit = context.read<TimerCubit>();
    if (!timerCubit.isLoaded) {
      return _noTimerErrorScreen(context);
    }
    return Scaffold(
      appBar: StandardComponents.getAppBar(
          context, timerCubit.loadedState.session.name),
      body: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          if (state is! TimerStateLoaded) {
            return const SizedBox.shrink();
          }
          if (state.isDone) {
            return _isDoneView(context);
          }
          return Container(
            margin: Layout.defaultPageContentMargin,
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: _currentIntervalView(context),
                ),
                if (state.hasNextInterval) ...[
                  Flexible(
                    flex: 1,
                    child: LayoutBuilder(
                      builder: (context, constraints) =>
                          _nextIntervalsPreview(context, constraints),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _isDoneView(BuildContext context) {
    TimerCubit timerCubit = context.read<TimerCubit>();
    return Container(
      margin: Layout.defaultContentMargin,
      decoration: MyDecoration.cardDecoration(context,
          color: MyColors.cardBackgroundColor),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "All done! :)",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            IconButton(
                onPressed: () => timerCubit.start(),
                icon: MyIcons.restartIntervalIcon),
          ],
        ),
      ),
    );
  }

  Widget _currentIntervalView(BuildContext context) {
    TimerCubit timerCubit = context.read<TimerCubit>();
    TimerStateLoaded state = timerCubit.loadedState;
    return Container(
      margin: Layout.defaultContentMargin,
      decoration: MyDecoration.cardDecoration(context,
          color: state.currentInterval.color.withOpacity(0.2)),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Center(
              child: SizedBox.square(
                dimension:
                    min(constraints.maxHeight, constraints.maxWidth) * 0.8,
                child: CircularProgressIndicator(
                  value: _currentIntervalProgress(state),
                  color: state.currentInterval.color,
                  strokeWidth: Layout.timerCircularStrokeWidth,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!state.isTicking) ...[
                    IconButton(
                      onPressed: () => timerCubit.resume(),
                      icon: MyIcons.playIcon,
                      iconSize: Layout.hugeIconSize,
                    )
                  ] else ...[
                    IconButton(
                      onPressed: () => timerCubit.pause(),
                      icon: MyIcons.pauseIcon,
                      iconSize: Layout.hugeIconSize,
                    )
                  ],
                  Text(
                    state.currentInterval.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    TypeConverter.durationToString(
                      state.remainingTimeCurrentInterval,
                      showFractions: true,
                      addAppendix: false,
                    ),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => timerCubit.resetInterval(),
                        icon: MyIcons.restartIntervalIcon,
                        iconSize: Layout.hugeIconSize,
                      ),
                      const SizedBox(width: Layout.defaultHorizontalSpace),
                      IconButton(
                        onPressed: () => timerCubit.stop(),
                        icon: MyIcons.stopIntervalIcon,
                        iconSize: Layout.hugeIconSize,
                      ),
                      //IconButton(onPressed: () => timerCubit.startNextInterval(), icon: MyIcons.skipIntervalIcon),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextIntervalsPreview(
      BuildContext context, BoxConstraints constraints) {
    TimerCubit timerCubit = context.read<TimerCubit>();
    TimerStateLoaded state = timerCubit.loadedState;
    int intervalsCount = state.intervals.length - state.nextIndex;

    return Scrollbar(
        controller: controller,
        child: ListView.builder(
          controller: controller,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: intervalsCount,
            itemBuilder: (ctx, index) =>
                _nextIntervalPreview(ctx, state.nextIndex + index)
        )
    );
  }

  Widget _nextIntervalPreview(BuildContext context, int intervalIndex) {
    TimerCubit timerCubit = context.read<TimerCubit>();
    TimerStateLoaded state = timerCubit.loadedState;
    SessionInterval interval = state.intervals[intervalIndex];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => timerCubit.startInterval(intervalIndex),
      child: Container(
        padding: Layout.cardPadding,
        margin: Layout.defaultContentMargin,
        width: 70,
        decoration:
            MyDecoration.cardDecoration(context, color: interval.color),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Next Interval:",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),*/
            Text(
              interval.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              TypeConverter.durationToString(
                interval.duration,
                addAppendix: false,
              ),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  double _currentIntervalProgress(TimerStateLoaded state) {
    return (state.currentInterval.duration.inMilliseconds -
            state.remainingTimeCurrentInterval.inMilliseconds) /
        state.currentInterval.duration.inMilliseconds;
  }

  Widget _noTimerErrorScreen(BuildContext context) {
    return Scaffold(
      appBar: StandardComponents.getAppBar(context, "No Timer"),
      body: const Center(
        child: Text(
          "Error! There is no timer loaded!",
          style: TextStyle(color: MyColors.errorColor),
        ),
      ),
    );
  }
}
