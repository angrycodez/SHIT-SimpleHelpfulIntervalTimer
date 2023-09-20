part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState();
  @override
  List<Object?> get props => [];
}

class TimerStateLoaded extends TimerState {
  final Session session;
  final List<SessionInterval> intervals;
  final int currentIntervalIndex;
  int get nextIndex => intervals.length > currentIntervalIndex + 1 ? currentIntervalIndex + 1 : -1;
  bool get hasNextInterval => nextIndex != -1;
  final Duration remainingTimeCurrentInterval;
  SessionInterval get currentInterval => intervals[currentIntervalIndex];
  Duration get remainingTimeTotal => Duration(
      seconds: intervals.skip(currentIntervalIndex + 1).fold(
              0,
              (previousValue, element) =>
                  previousValue + element.duration.inSeconds) +
          remainingTimeCurrentInterval.inSeconds,
  );
  int get computeRemainingTimeInMillis => currentInterval.duration.inMilliseconds - (DateTime.now().millisecondsSinceEpoch - intervalStartedTimestamp!.millisecondsSinceEpoch);
  final DateTime? intervalStartedTimestamp;
  final bool isPaused;
  final bool isDone;
  bool get isTicking => intervalStartedTimestamp != null && !(isPaused || isDone);

  const TimerStateLoaded({
    required this.session,
    required this.intervals,
    required this.currentIntervalIndex,
    required this.remainingTimeCurrentInterval,
    this.intervalStartedTimestamp,
    this.isPaused= false,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [
        intervals,
        currentIntervalIndex,
        remainingTimeCurrentInterval,
        intervalStartedTimestamp,
        isPaused,
        isDone,
        isTicking,
      ];

  TimerStateLoaded copyWith({
    Session? session,
    List<SessionInterval>? intervals,
    int? currentIntervalIndex,
    Duration? remainingTimeCurrentInterval,
    DateTime? intervalStartedTimestamp,
    bool? isPaused,
    bool? isDone,
  }) {
    return TimerStateLoaded(
      session: session ?? this.session,
      intervals: intervals ?? this.intervals,
      currentIntervalIndex: currentIntervalIndex ?? this.currentIntervalIndex,
      remainingTimeCurrentInterval:
          remainingTimeCurrentInterval ?? this.remainingTimeCurrentInterval,
      intervalStartedTimestamp:
          intervalStartedTimestamp ?? this.intervalStartedTimestamp,
      isPaused: isPaused ?? this.isPaused,
      isDone: isDone ?? this.isDone,
    );
  }
}
