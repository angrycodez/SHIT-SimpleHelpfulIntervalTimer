import '../datasources/local/daos/daos.dart';
import '../datasources/local/database.dart';
import '../models/models.dart';

class SettingsRepository {
  final SessionDatabase _db;
  late final SoundsDao _soundsDao;
  late final SettingsDao _settingsDao;

  SettingsRepository(this._db) {
    _soundsDao = SoundsDao(_db);
    _settingsDao = SettingsDao(_db);
  }

  Future updateSettings(Settings settings)async{
    await _settingsDao.updateSettings(settings);
  }

  Future<Settings> getSettings() async {
    var settingsEntry = await _settingsDao.getSettings();
    Sound? defaultIntervalStartSound =
        await _getSound(settingsEntry.defaultIntervalStartSound);
    Sound? defaultIntervalEndSound =
        await _getSound(settingsEntry.defaultIntervalEndSound);
    Sound? defaultSessionEndSound =
        await _getSound(settingsEntry.defaultSessionEndSound);

    return Settings(
      id: settingsEntry.id,
      defaultIntervalStartSound: defaultIntervalStartSound,
      defaultIntervalEndSound: defaultIntervalEndSound,
      defaultSessionEndSound: defaultSessionEndSound,
    );
  }

  Future<Sound?> _getSound(String? id) async {
    var soundEntry = await _soundsDao.getSound(id ?? "");
    if (soundEntry != null) {
      return Sound.fromEntry(soundEntry);
    }
    return null;
  }
}
