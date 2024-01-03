import 'dart:async';
import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:simple_interval_timer/core/services/audio_service.dart';
import 'package:simple_interval_timer/data/models/models.dart';


class JAAudioService extends AudioService{
  late AudioPlayer _player;
  StreamSubscription? _completeListener;

  JAAudioService() {
    _player = AudioPlayer();
    _completeListener = _player.processingStateStream.listen(_onProcessingStateChanged);
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
    await _player.setAudioSource(AudioSource.file(path));
    await _player.play();
  }

  Future _onProcessingStateChanged(ProcessingState state) async{
    if(state == ProcessingState.completed){
      await stop();
    }
  }

  @override
  Future stop() async {
    await _player.stop();
  }
}
