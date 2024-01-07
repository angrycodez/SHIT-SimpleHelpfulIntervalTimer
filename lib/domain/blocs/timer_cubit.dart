import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:process_run/process_run.dart';
import 'package:simple_interval_timer/core/services/audio_service.dart';

import '../../data/models/models.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  late AudioService _audioService;
  TimerCubit() : super(const TimerState()){
    _audioService = AudioService.get();
  }

  @override Future<void> close() async {
    await _audioService.dispose();
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
    _startInterval(0);
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
    }else{
      start();
    }

  }
  void stop(){
    if(!isLoaded){
      return;
    }
    init(loadedState.session);
  }

  void resetInterval(){
    if(!isLoaded){
      return;
    }
    _startInterval(loadedState.currentIntervalIndex);
  }

  bool _startInterval(int index){
    if(!isLoaded){
      return false;
    }
    if(index < 0 || loadedState.intervals.length < index){
      _finish();
      return false;
    }else{
      bool startTicking = !loadedState.isTicking;
      emit(loadedState.copyWith(
        remainingTimeCurrentInterval: loadedState.intervals[index].duration,
        currentIntervalIndex: index,
        intervalStartedTimestamp: DateTime.now(),
        isPaused: false,
        isDone: false,
      ));
      if(startTicking){
        _tick();
      }
      _audioService.play(loadedState.currentInterval.startSound);
      _executeCommand(loadedState.currentInterval.startCommand);
      return true;
    }
  }
  void _executeCommand(String? command){
    if(command == null || command.isEmpty){
      return;
    }
    Shell().run(command);
  }

  bool startNextInterval(){
    if(!isLoaded){
      return false;
    }
    int nextIndex = loadedState.nextIndex;
    // there are no more intervals left => session is done
    return _startInterval(nextIndex);
  }

  void _finish(){
    if(!isLoaded){
      return;
    }
    _audioService.play(loadedState.session.endSound);
    emit(loadedState.copyWith(isDone: true));
  }



  void _tick(){
    if(!isLoaded){
      return;
    }
    if(!loadedState.isTicking){
      return;
    }

    int millisecondsRemaining =  loadedState.computeCurrentIntervalRemainingTimeInMillis;

    // current interval has finished
    if(millisecondsRemaining <= 0){
      // there are no more intervals left => session is done
      if(!startNextInterval()){
        _finish();
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
