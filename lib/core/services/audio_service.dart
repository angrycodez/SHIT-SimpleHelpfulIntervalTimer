

import 'package:audioplayers/audioplayers.dart';

import '../../data/models/models.dart';

class AudioService{
  late AudioPlayer _player;

  AudioService(){
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen(_onPlayerStateChanged);
  }

  void dispose(){
    _player.dispose();
  }

  void _onPlayerStateChanged(PlayerState state){
    switch(state){
      case PlayerState.completed:
          _player.stop();
          break;
      default: break;
    }
  }

  void play(Sound? sound){
    if(sound == null){
      return;
    }
    _player.play(
        DeviceFileSource(sound.filepath),
        mode: PlayerMode.lowLatency,
    );
  }
}