class SessionStepEntry {
  String id;
  String? name;
  String? parentBlockId;
  int sequenceIndex;
  SessionStepEntry({
    required this.id,
    this.name,
    this.parentBlockId,
    required this.sequenceIndex,
  });
}

class SessionBlockEntry extends SessionStepEntry {
  int repetitions;
  SessionBlockEntry({
    required super.id,
    super.name,
    super.parentBlockId,
    required super.sequenceIndex,
    required this.repetitions,
  });
}

class SessionIntervalEntry extends SessionStepEntry {
  int durationInSeconds;
  bool isPause;
  String? startSoundId;
  String? endSoundId;
  SessionIntervalEntry({
    required super.id,
    super.name,
    super.parentBlockId,
    required super.sequenceIndex,
    required this.durationInSeconds,
    required this.isPause,
    this.startSoundId,
    this.endSoundId,
  });
}
