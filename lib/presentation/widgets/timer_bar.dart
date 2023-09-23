import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/helper/converter.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/timer_page.dart';

class TimerBar extends StatelessWidget {
  final TimerStateLoaded timerState;

  const TimerBar({super.key, required this.timerState});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(TimerPage.getRoute()),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: _currentInterval(),
          ),
        ],
      ),
    );
  }

  int _getProgress() {
    double part = (timerState.remainingTimeCurrentInterval.inMilliseconds /
        timerState.currentInterval.duration.inMilliseconds);
    return (part * 100).floor();
  }

  Widget _currentInterval() {
    int progress = _getProgress();
    return SizedBox(
      height: 25,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 100 - progress,
                child: Container(
                  color: timerState.currentInterval.color,
                ),
              ),
              Flexible(
                flex: progress,
                child: Container(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(timerState.currentInterval.name),
                Text(TypeConverter.durationToString(
                    timerState.remainingTimeCurrentInterval)),
                if (timerState.hasNextInterval) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyIcons.nextIntervalIcon,
                      const SizedBox(width: 5),
                      Text(timerState.intervals[timerState.nextIndex].name),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
