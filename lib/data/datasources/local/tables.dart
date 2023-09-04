

import 'package:drift/drift.dart';
import 'package:simple_interval_timer/data/datasources/local/daos/models.dart';
import 'package:uuid/uuid.dart';

@DataClassName("SessionEntry")
class Sessions extends Table with UuidPrimaryKey{
  TextColumn get name => text().withLength(min: 1, max: 64)();
}

@UseRowClass(SessionIntervalEntry)
class SessionIntervals extends Table with UuidPrimaryKey{
  TextColumn get name => text().nullable().withLength(min: 1, max: 64)();

  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get parentBlockId => text().nullable().references(SessionBlocks, #id)();

  IntColumn get sequenceIndex => integer()();
  IntColumn get durationInSeconds => integer()();
  BoolColumn get isPause => boolean()();
  TextColumn get startSoundId => text().nullable().references(Sounds, #id)();
  TextColumn get endSoundId => text().nullable().references(Sounds, #id)();
}

@UseRowClass(SessionBlockEntry)
class SessionBlocks extends Table with UuidPrimaryKey{
  TextColumn get name => text().nullable().withLength(min: 1, max: 64)();

  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get parentBlockId => text().nullable().references(SessionBlocks, #id)();

  IntColumn get sequenceIndex => integer()();
  IntColumn get repetitions => integer()();
}

@DataClassName("SoundEntry")
class Sounds extends Table with UuidPrimaryKey{
  TextColumn get filename => text()();
  TextColumn get path => text()();
}

// Tables can mix-in common definitions if needed
mixin UuidPrimaryKey on Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  @override
  Set<Column> get primaryKey => {id};
}