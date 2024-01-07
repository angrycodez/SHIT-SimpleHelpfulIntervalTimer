class SessionStepEntry {
  String id;
  String name;
  String? parentBlockId;
  int sequenceIndex;
  SessionStepEntry({
    required this.id,
    required this.name,
    this.parentBlockId,
    required this.sequenceIndex,
  });
}

class SessionBlockEntry extends SessionStepEntry {
  int repetitions;
  SessionBlockEntry({
    required super.id,
    required super.name,
    super.parentBlockId,
    required super.sequenceIndex,
    required this.repetitions,
  });
}

class SessionIntervalEntry extends SessionStepEntry {
  int durationInSeconds;
  bool isPause;
  String? startSoundId;
  String? startCommand;
  int color;
  SessionIntervalEntry({
    required super.id,
    required super.name,
    super.parentBlockId,
    required super.sequenceIndex,
    required this.durationInSeconds,
    required this.isPause,
    this.startSoundId,
    this.startCommand,
    required this.color,
  });
}
