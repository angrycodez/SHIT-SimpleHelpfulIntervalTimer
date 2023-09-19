// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';

class Sound extends Equatable {
  String id;
  String filename;
  String filepath;
  Sound(this.id, this.filename, this.filepath);

  Sound.fromEntry(SoundEntry sound)
      : this(
          sound.id,
          sound.filename,
          sound.path,
        );

  @override
  List<Object> get props => [
        id,
        filename,
        filepath,
      ];

  Sound copyWith({
    String? id,
    String? filename,
    String? filepath,
  }) {
    return Sound(
      id ?? this.id,
      filename ?? this.filename,
      filepath ?? this.filepath,
    );
  }
}
