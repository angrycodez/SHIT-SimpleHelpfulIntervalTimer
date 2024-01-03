part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final String id;
  final List<Sound> sounds;
  final Sound? defaultIntervalStartSound;
  final Sound? defaultSessionEndSound;
  bool get isInitialized => id.isNotEmpty;
  const SettingsState({
    required this.id,
    this.sounds = const [],
    this.defaultIntervalStartSound,
    this.defaultSessionEndSound,
  });

  @override
  List<Object?> get props => [
        id,
        sounds,
        defaultIntervalStartSound,
        defaultSessionEndSound,
      ];

  SettingsState copyWithDefaultIntervalStartSound(
      Sound? defaultIntervalStartSound) {
    return SettingsState(
      id: id,
      sounds: sounds,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }
  SettingsState copyWithDefaultSessionEndSound(
      Sound? defaultSessionEndSound) {
    return SettingsState(
      id: id,
      sounds: sounds,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }
  SettingsState copyWith({
    String? id,
    List<Sound>? sounds,
    Sound? defaultIntervalStartSound,
    Sound? defaultSessionEndSound,
  }) {
    return SettingsState(
      id: id ?? this.id,
      sounds: sounds ?? this.sounds,
      defaultIntervalStartSound:
          defaultIntervalStartSound ?? this.defaultIntervalStartSound,
      defaultSessionEndSound:
          defaultSessionEndSound ?? this.defaultSessionEndSound,
    );
  }
}
