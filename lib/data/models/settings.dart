

import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

class Settings extends Equatable{
  String id;
  Sound? defaultIntervalStartSound;
  Sound? defaultIntervalEndSound;
  Sound? defaultSessionEndSound;

  Settings({required this.id, this.defaultIntervalStartSound, this.defaultIntervalEndSound, this.defaultSessionEndSound,});

  @override
  List<Object?> get props => [id, defaultIntervalStartSound, defaultIntervalEndSound, defaultSessionEndSound,];

  Settings copyWith({
    String? id,
    Sound? defaultIntervalStartSound,
    Sound? defaultIntervalEndSound,
    Sound? defaultSessionEndSound,
  }) {
    return Settings(
      id: id ?? this.id,
      defaultIntervalStartSound:
          defaultIntervalStartSound ?? this.defaultIntervalStartSound,
      defaultIntervalEndSound:
          defaultIntervalEndSound ?? this.defaultIntervalEndSound,
      defaultSessionEndSound:
          defaultSessionEndSound ?? this.defaultSessionEndSound,
    );
  }
}