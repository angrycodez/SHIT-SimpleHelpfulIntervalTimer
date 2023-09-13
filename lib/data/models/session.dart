// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

import 'package:simple_interval_timer/data/models/models.dart';

class Session extends Equatable {
  String id;
  String name;
  String description;
  List<SessionStep> steps;
  List<SessionStep> get distinctSteps => steps.fold(List<SessionStep>.empty(growable: true), (previousValue, element) {
    if(element is SessionInterval){
      previousValue.add(element);
    }else{
      previousValue.addAll((element as SessionBlock).distinctSteps);
    }
    return previousValue;
  }).toList();

  List<SessionInterval> get intervalSequence {
    List<SessionInterval> intervals = List.empty(growable: true);
    for(var step in steps){
      intervals.addAll(step.intervalSequence);
    }
    return intervals;
  }
  Duration get duration => steps.fold(Duration.zero, (previousValue, element) => Duration(seconds: previousValue.inSeconds + element.duration.inSeconds));

  Session(this.id, this.name, this.description, this.steps);


  @override
  List<Object> get props => [id, name, description, steps];

  Session copyWith({
    String? id,
    String? name,
    String? description,
    List<SessionStep>? steps,
  }) {
    return Session(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      steps ?? this.steps,
    );
  }
}

