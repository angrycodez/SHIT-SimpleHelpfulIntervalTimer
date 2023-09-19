import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  TimerStateLoaded get loadedState{
    assert(state is TimerStateLoaded);
    return state as TimerStateLoaded;
  }

  final Duration _tickRate = const Duration(milliseconds: 100);

  bool get isLoaded => state is TimerStateLoaded;
  
  void init(Session session){
    emit(const TimerState());
    var intervals = session.intervalSequence;
    if(intervals.isEmpty){
      return;
    }
    emit(TimerStateLoaded(
      session: session,
      intervals: intervals,
      currentIntervalIndex: 0,
      remainingTimeCurrentInterval: intervals[0].duration,
    ));
  }

  void start(){
    if(!isLoaded){
      return;
    }
    emit(loadedState.copyWith(intervalStartedTimestamp: DateTime.now()));
    _tick();
  }


  void pause(){
    if(!isLoaded){
      return;
    }
    emit(loadedState.copyWith(isPaused: true));
  }
  void stop(){
    if(!isLoaded){
      return;
    }
    init(loadedState.session);
  }


  void _tick(){
    if(!isLoaded){
      return;
    }
    if(!loadedState.isTicking){
      return;
    }
    print("${loadedState.currentInterval.name} - ${loadedState.remainingTimeCurrentInterval.toString()} - ${loadedState.remainingTimeTotal.toString()}");
    int millisecondsRemaining =  loadedState.currentInterval.duration.inMilliseconds - (DateTime.now().millisecondsSinceEpoch - loadedState.intervalStartedTimestamp!.millisecondsSinceEpoch);

    int? intervalIndex;
    DateTime? intervalStartedTimestamp;
    // current interval has finished
    if(millisecondsRemaining <= 0){
      int nextIndex = loadedState.nextIndex;
      // there are no more intervals left => session is done
      if(nextIndex == -1){
        emit(loadedState.copyWith(isDone: true));
        print("DONE");
        return;
      }else{
        // move to the next interval
        intervalIndex = nextIndex;
        millisecondsRemaining = loadedState.intervals[intervalIndex].duration.inMilliseconds;
        intervalStartedTimestamp = DateTime.now();
      }
    }

    // keep ticking
    Future.delayed(_tickRate, _tick);
    emit(loadedState.copyWith(
      remainingTimeCurrentInterval: Duration(milliseconds: millisecondsRemaining),
      currentIntervalIndex: intervalIndex,
      intervalStartedTimestamp: intervalStartedTimestamp,
    ));
  }
}
