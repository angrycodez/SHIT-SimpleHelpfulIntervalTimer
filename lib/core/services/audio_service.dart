

import 'package:audioplayers/audioplayers.dart';

import '../../data/models/models.dart';

class AudioService{
  late AudioPlayer _player;
  List<Sound> queue = List.empty(growable: true);

  AudioService(){
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged(PlayerState state){
    switch(state){
      case PlayerState.completed:
        queue.removeAt(0);
        if(queue.isNotEmpty){
          _play();
        }else{
          _player.stop();
        }
      default: break;
    }
  }

  void _play(){
    if(queue.isEmpty || _player.state == PlayerState.playing){
      return;
    }
    var source = DeviceFileSource(queue.first.filepath);
    _player.play(source, mode: PlayerMode.lowLatency);
  }

  void play(Sound sound){
    queue.add(sound);
    _play();
  }
}