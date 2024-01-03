import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:simple_interval_timer/core/services/audio_service.dart';
import 'package:simple_interval_timer/data/models/models.dart';


class APAudioService extends AudioService{
  late AudioPlayer _player;
  StreamSubscription? _completeListener;

  APAudioService() {
    _player = AudioPlayer();
    _completeListener = _player.onPlayerComplete.listen(_onPlayerComplete);
  }

  @override
  Future dispose() async {
    await _completeListener?.cancel();
    await _player.dispose();
  }


  @override
  Future play(Sound? sound) async {
    if (sound == null) {
      return;
    }
    String path = sound.filepath;
    if(!File(path).existsSync()){
      return;
    }
    await _player.stop();
    await _player.play(
      DeviceFileSource(path),
      mode: PlayerMode.lowLatency,
    );
  }

  Future _onPlayerComplete(void _) async{
    await _player.stop();
  }

  @override
  Future stop() async {
    await _player.stop();
  }
}
