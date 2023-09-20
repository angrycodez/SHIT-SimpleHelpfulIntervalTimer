import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/services/audio_service.dart';
import '../../data/models/models.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  late AudioService _audioService;
  TimerCubit() : super(const TimerState()){
    _audioService = AudioService();
  }

  @override Future<void> close() {
    _audioService.dispose();
    return super.close();
  }

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
    _audioService.play(loadedState.currentInterval.startSound);
    _tick();
  }


  void pause(){
    if(!isLoaded){
      return;
    }
    emit(loadedState.copyWith(isPaused: true));
  }
  void resume(){
    if(!isLoaded){
      return;
    }
    if(loadedState.isPaused){
      Duration remainingTime = loadedState.remainingTimeCurrentInterval;
      Duration totalTimeCurrentInterval = loadedState.currentInterval.duration;
      Duration timePassed = totalTimeCurrentInterval - remainingTime;
      var referenceTimestamp = DateTime.now().subtract(timePassed);
      emit(loadedState.copyWith(isPaused: false, intervalStartedTimestamp: referenceTimestamp,));
      _tick();
    }

  }
  void stop(){
    if(!isLoaded){
      return;
    }
    init(loadedState.session);
  }

  bool startNextInterval(){
    if(!isLoaded){
      return false;
    }
    int nextIndex = loadedState.nextIndex;
    // there are no more intervals left => session is done
    if(nextIndex == -1){
      _finish();
      return false;
    }else{
      // move to the next interval

      emit(loadedState.copyWith(
        remainingTimeCurrentInterval: loadedState.intervals[nextIndex].duration,
        currentIntervalIndex: nextIndex,
        intervalStartedTimestamp: DateTime.now(),
      ));
      _audioService.play(loadedState.currentInterval.startSound);
      return true;
    }
  }

  void _finish(){
    if(!isLoaded){
      return;
    }
    emit(loadedState.copyWith(isDone: true));
  }



  void _tick(){
    if(!isLoaded){
      return;
    }
    if(!loadedState.isTicking){
      return;
    }

    int millisecondsRemaining =  loadedState.computeRemainingTimeInMillis;

    // current interval has finished
    if(millisecondsRemaining <= 0){
      _audioService.play(loadedState.currentInterval.endSound);
      // there are no more intervals left => session is done
      if(!startNextInterval()){
        _finish();
        _audioService.play(loadedState.session.endSound);
        return;
      }else{
        Future.delayed(_tickRate, _tick);
        return;
      }
    }
    // keep ticking
    Future.delayed(_tickRate, _tick);
    emit(loadedState.copyWith(
      remainingTimeCurrentInterval: Duration(milliseconds: millisecondsRemaining),
    ));
  }
}
