



import 'package:simple_interval_timer/data/datasources/local/daos/sounds_dao.dart';

import '../datasources/local/database.dart';
import '../models/models.dart';

class SoundRepository {
  final SessionDatabase _db;
  late final SoundsDao _soundsDao;


  SoundRepository(this._db) {
    _soundsDao = SoundsDao(_db);
  }

  Future<List<Sound>> getSounds() async {
    return (await _soundsDao.getSounds()).map((e) => Sound.fromEntry(e)).toList();
  }

  Future storeSound(Sound sound) async{
    await _soundsDao.storeSound(sound);
  }

  Future deleteSound(Sound sound) async{
    await _soundsDao.deleteSound(sound.id);
  }

}