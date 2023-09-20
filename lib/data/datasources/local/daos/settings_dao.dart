import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';
import '../../../models/models.dart' as models;

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<SessionDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(SessionDatabase db) : super(db);

  Future<SettingsEntry> getSettings() async {
    return await db.settings.select().getSingle();
  }

  Future updateSettings(models.Settings settings) async {
    await db.settings.update().replace(
          SettingsCompanion.insert(
            id: Value(settings.id),
            defaultIntervalStartSound:
                Value(settings.defaultIntervalStartSound?.id),
            defaultIntervalEndSound:
                Value(settings.defaultIntervalEndSound?.id),
            defaultSessionEndSound:
                Value(settings.defaultSessionEndSound?.id),
          ),
        );
  }
}
