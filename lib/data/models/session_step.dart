// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:simple_interval_timer/data/models/models.dart';

abstract class SessionStep extends Equatable {
  final String id;
  final String name;
  final SessionBlock? parentStep;
  final int sequenceIndex;
  Duration get duration => Duration.zero;
  List<SessionInterval> get intervalSequence;

  const SessionStep({
    required this.id,
    required this.name,
    this.parentStep,
    required this.sequenceIndex,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      parentStep,
      sequenceIndex,
    ];
  }
}

class SessionBlock extends SessionStep {
  final int repetitions;
  final List<SessionStep> children;
  List<SessionStep> get distinctSteps => children.fold(List<SessionStep>.of([this]), (previousValue, element) {
    if(element is SessionInterval){
      previousValue.add(element);
    }else{
      previousValue.addAll((element as SessionBlock).distinctSteps);
    }
    return previousValue;
  }).toList();

  @override
  List<SessionInterval> get intervalSequence {
    List<SessionInterval> intervals = List.empty(growable: true);
    for(int i=0; i<repetitions;i++) {
      for (var step in children) {
        intervals.addAll(step.intervalSequence);
      }
    }
    return intervals;
  }

  @override
  Duration get duration => children.fold(Duration.zero, (previousValue, element) =>Duration(seconds: previousValue.inSeconds + element.duration.inSeconds));

  const SessionBlock(
      {required String id,
      required String name,
      SessionBlock? parentStep,
      required int sequenceIndex,
      required this.repetitions,
      required this.children})
      : assert(repetitions > 0),
        super(
          id: id,
          name: name,
          parentStep: parentStep,
          sequenceIndex: sequenceIndex,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        repetitions,
        children,
      ];

  SessionBlock copyWith({
    String? id,
    String? name,
    SessionBlock? parentStep,
    int? sequenceIndex,
    int? repetitions,
    List<SessionStep>? children,
  }) {
    return SessionBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      parentStep: parentStep ?? this.parentStep,
      sequenceIndex: sequenceIndex ?? this.sequenceIndex,
      repetitions: repetitions ?? this.repetitions,
      children: children ?? this.children,
    );
  }

}

class SessionInterval extends SessionStep {
  @override
  final Duration duration;
  final bool isPause;
  final Sound? startSound;
  final Sound? endSound;

  @override
  List<SessionInterval> get intervalSequence => List.of([this]);

  const SessionInterval({
    required String id,
    required String name,
    SessionBlock? parentStep,
    required int sequenceIndex,
    required this.duration,
    required this.isPause,
    this.startSound,
    this.endSound,
  }) : super(
          id: id,
          name: name,
          parentStep: parentStep,
          sequenceIndex: sequenceIndex,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        duration,
        isPause,
        startSound,
        endSound,
      ];

  SessionInterval copyWith({
    String? id,
    String? name,
    SessionBlock? parentStep,
    int? sequenceIndex,
    Duration? duration,
    bool? isPause,
    Sound? startSound,
    Sound? endSound,
  }) {
    return SessionInterval(
      id: id ?? this.id,
      name: name ?? this.name,
      parentStep: parentStep ?? this.parentStep,
      sequenceIndex: sequenceIndex ?? this.sequenceIndex,
      duration: duration ?? this.duration,
      isPause: isPause ?? this.isPause,
      startSound: startSound ?? this.startSound,
      endSound: endSound ?? this.endSound,
    );
  }
}
