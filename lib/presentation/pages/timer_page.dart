import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/converter.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => TimerPage(key: key));
  }

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
            return SizedBox.shrink();
          }
          if(state.isDone){
            return Center(child: Text("Done :)"),);
          }
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox.square(
                        dimension: 280,
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
                          if(!state.isTicking)...[
                            IconButton(onPressed: ()=>timerCubit.resume(), icon: MyIcons.playIcon)
                          ]else...[
                            IconButton(onPressed: ()=>timerCubit.pause(), icon: MyIcons.pauseIcon)
                          ],
                          Text(state.currentInterval.name ?? ""),
                          Text(
                            TypeConverter.durationToString(
                              state.remainingTimeCurrentInterval,
                              showFractions: true,
                              addAppendix: false,
                            ),
                            style: TextStyle(fontSize: 25),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: () => timerCubit.resetInterval(), icon: MyIcons.restartIntervalIcon),
                              IconButton(onPressed: () => timerCubit.stop(), icon: MyIcons.stopIntervalIcon),
                              IconButton(onPressed: () => timerCubit.startNextInterval(), icon: MyIcons.skipIntervalIcon),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (state.hasNextInterval) ...[
                Flexible(
                  flex: 1,
                  child: _nextIntervalPreview(state),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
  
  Widget _nextIntervalPreview(TimerStateLoaded state){
    SessionInterval nextInterval = state.intervals[state.nextIndex];
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(nextInterval.name ?? ""),
          Text(
            TypeConverter.durationToString(
              nextInterval.duration,
              addAppendix: false,
            ),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  double _currentIntervalProgress(TimerStateLoaded state){
    return (state.currentInterval.duration.inMilliseconds - state.remainingTimeCurrentInterval.inMilliseconds) / state.currentInterval.duration.inMilliseconds;
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
