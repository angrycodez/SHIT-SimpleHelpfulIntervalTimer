import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/models/models.dart';

class Settings extends Equatable {
  final String id;
  final Sound? defaultIntervalStartSound;
  final Sound? defaultSessionEndSound;

  const Settings({
    required this.id,
    this.defaultIntervalStartSound,
    this.defaultSessionEndSound,
  });

  @override
  List<Object?> get props => [
        id,
        defaultIntervalStartSound,
        defaultSessionEndSound,
      ];

  Settings copyWith({
    String? id,
    Sound? defaultIntervalStartSound,
    Sound? defaultSessionEndSound,
  }) {
    return Settings(
      id: id ?? this.id,
      defaultIntervalStartSound:
          defaultIntervalStartSound ?? this.defaultIntervalStartSound,
      defaultSessionEndSound:
          defaultSessionEndSound ?? this.defaultSessionEndSound,
    );
  }
}
