import 'package:drift/drift.dart';

import '../../../models/models.dart';
import '../database.dart';
import '../tables.dart';

part 'sounds_dao.g.dart';

@DriftAccessor(tables: [Sounds])
class SoundsDao extends DatabaseAccessor<SessionDatabase>
    with _$SoundsDaoMixin {
  SoundsDao(SessionDatabase db) : super(db);

  Future<List<SoundEntry>> getSounds() async {
    return await db.sounds.select().get();
  }
  Future<SoundEntry?> getSound(String id) async {
    return await (db.sounds.select()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future storeSound(Sound sound) async {
    await db.sounds.insertOnConflictUpdate(
      SoundsCompanion.insert(
        id: Value(sound.id),
        filename: sound.filename,
        path: sound.filepath,
      ),
    );
  }

  Future deleteSound(String soundId)async{
    await db.sounds.deleteWhere((tbl) => tbl.id.equals(soundId));
  }
}
