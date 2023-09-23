import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:simple_interval_timer/data/models/models.dart';


class AudioService {
  late AudioPlayer _player;
  StreamSubscription? _completeListener;

  AudioService() {
    _player = AudioPlayer();
    _completeListener = _player.onPlayerComplete.listen(_onPlayerComplete);
  }

  Future dispose() async {
    await _completeListener?.cancel();
    await _player.dispose();
  }


  Future play(Sound? sound) async {
    if (sound == null) {
      return;
    }
    String path = sound.filepath;
    if(!File(path).existsSync()){
      return;
    }
    await _player.play(
      DeviceFileSource(path),
      mode: PlayerMode.lowLatency,
    );
  }

  Future _onPlayerComplete(void _) async{
    await _player.stop();
  }
}
