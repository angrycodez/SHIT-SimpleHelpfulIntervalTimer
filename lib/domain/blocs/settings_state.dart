part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final String id;
  final List<Sound> sounds;
  final Sound? defaultIntervalStartSound;
  final Sound? defaultIntervalEndSound;
  final Sound? defaultSessionEndSound;
  const SettingsState({
    required this.id,
    this.sounds = const [],
    this.defaultIntervalStartSound,
    this.defaultIntervalEndSound,
    this.defaultSessionEndSound,
  });

  @override
  List<Object?> get props => [
        id,
        sounds,
        defaultIntervalStartSound,
        defaultIntervalEndSound,
        defaultSessionEndSound,
      ];

  SettingsState copyWithDefaultIntervalStartSound(
      Sound? defaultIntervalStartSound) {
    return SettingsState(
      id: id,
      sounds: sounds,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultIntervalEndSound: defaultIntervalEndSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }
  SettingsState copyWithDefaultIntervalEndSound(
      Sound? defaultIntervalEndSound) {
    return SettingsState(
      id: id,
      sounds: sounds,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultIntervalEndSound: defaultIntervalEndSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }
  SettingsState copyWithDefaultSessionEndSound(
      Sound? defaultSessionEndSound) {
    return SettingsState(
      id: id,
      sounds: sounds,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultIntervalEndSound: defaultIntervalEndSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }
  SettingsState copyWith({
    String? id,
    List<Sound>? sounds,
    Sound? defaultIntervalStartSound,
    Sound? defaultIntervalEndSound,
    Sound? defaultSessionEndSound,
  }) {
    return SettingsState(
      id: id ?? this.id,
      sounds: sounds ?? this.sounds,
      defaultIntervalStartSound:
          defaultIntervalStartSound ?? this.defaultIntervalStartSound,
      defaultIntervalEndSound:
          defaultIntervalEndSound ?? this.defaultIntervalEndSound,
      defaultSessionEndSound:
          defaultSessionEndSound ?? this.defaultSessionEndSound,
    );
  }
}
