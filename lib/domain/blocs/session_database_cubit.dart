import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/repositories/session_repository.dart';
import 'package:simple_interval_timer/data/repositories/settings_repository.dart';
import 'package:simple_interval_timer/data/repositories/sound_repository.dart';

import '../../data/datasources/local/database.dart';

part 'session_database_state.dart';

class SessionDatabaseCubit extends Cubit<SessionDatabaseState> {
  SessionDatabaseCubit(SessionDatabase db) : super(SessionDatabaseState(db));
  Future ensureOpen()async{
    await state.database.executor.ensureOpen(state.database);
  }

  Future dispose()async{
    await state.database.close();
  }
  SessionDatabase get database => state.database;
  SessionRepository get sessionRepository => SessionRepository(database);
  SoundRepository get soundRepository => SoundRepository(database);
  SettingsRepository get settingsRepository => SettingsRepository(database);
}
