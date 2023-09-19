import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/helper/converter.dart';
import 'package:simple_interval_timer/data/models/models.dart';
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
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: _currentInterval(),
          ),
          if(timerState.hasNextInterval)...[
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: _previewNextInterval(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _currentInterval() {
    return Container(
      color: Colors.lightGreenAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              timerState.currentInterval.name ?? timerState.currentInterval.id),
          Text(TypeConverter.durationToString(
              timerState.remainingTimeCurrentInterval)),
        ],
      ),
    );
  }

  Widget _previewNextInterval() {
    int nextIndex = timerState.nextIndex;
    SessionInterval nextInterval = timerState.intervals[nextIndex];
    return Container(
      color: Colors.orange,
      child: Row(
        children: [
          Text(nextInterval.name ?? nextInterval.id),
          Text(TypeConverter.durationToString(nextInterval.duration)),
        ],
      ),
    );
  }
}
