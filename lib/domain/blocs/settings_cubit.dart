import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import '../../data/models/models.dart';
import '../../data/repositories/repositories.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SessionDatabaseCubit _databaseCubit;
  SoundRepository get _soundRepository => _databaseCubit.soundRepository;
  SettingsRepository get _settingsRepository =>
      _databaseCubit.settingsRepository;
  SettingsCubit(this._databaseCubit) : super(const SettingsState(id: "")) {
    loadSettings();
  }

  Settings getObject() {
    return Settings(
      id: state.id,
      defaultIntervalStartSound: state.defaultIntervalStartSound,
      defaultSessionEndSound: state.defaultSessionEndSound,
    );
  }

  Future storeSettings() async {
    await _settingsRepository.updateSettings(getObject());
  }

  Future loadSettings() async {
    Settings settings = await _settingsRepository.getSettings();
    await loadSounds();
    emit(
      state.copyWith(
        id: settings.id,
        defaultIntervalStartSound: settings.defaultIntervalStartSound,
        defaultSessionEndSound: settings.defaultSessionEndSound,
      ),
    );
  }

  Future loadSounds() async {
    List<Sound> sounds = await _databaseCubit.soundRepository.getSounds();
    emit(state.copyWith(sounds: sounds));
  }

  Future deleteSound(Sound sound) async {
    await _soundRepository.deleteSound(sound);
    await loadSounds();
    var file = File(sound.filepath);
    if(file.existsSync()){
      file.deleteSync();
    }
  }

  Future addSoundFile(PlatformFile file) async {
    final String soundsFolder = path.join(
        (await getApplicationDocumentsDirectory()).path, 'shit/sounds');
    String newPath = path.join(soundsFolder, file.name);
    var newFile = File(newPath);
    if (newFile.existsSync()) {
      return;
    }
    if(!newFile.parent.existsSync()){
      newFile.parent.createSync(recursive: true);
    }
    File(file.path!).copy(newPath);
    var sound = Sound(
      const Uuid().v4(),
      file.name,
      newPath,
    );
    await _soundRepository.storeSound(sound);
    await loadSounds();
  }

  void setDefaultIntervalStartSound(Sound? sound) {
    emit(state.copyWithDefaultIntervalStartSound(sound));
  }

  void setDefaultSessionEndSound(Sound? sound) {
    emit(state.copyWithDefaultSessionEndSound(sound));
  }
}
