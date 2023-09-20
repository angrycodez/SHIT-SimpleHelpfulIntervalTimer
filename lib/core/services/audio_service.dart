

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import '../../data/models/models.dart';

class AudioService{
  late AudioPlayer _player;
  final List<Sound> sounds = List.empty(growable: true);

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
          _play();
          break;
      default: break;
    }
  }

  void _play(){
    if(sounds.isEmpty){
      _player.stop();
      return;
    }
    if(_player.state != PlayerState.playing){
      String path = sounds.first.filepath;
      if(!File(path).existsSync()){
        return;
      }
      print("Play sound ${sounds.first.filename}");
      sounds.removeAt(0);
      print("These are the sounds: ${sounds.map((e) => "${e.filename}, ")}");
      _player.play(
        DeviceFileSource(path),
        mode: PlayerMode.lowLatency,
      );
    }
  }

  void play(Sound? sound){
    if(sound == null){
      return;
    }
    print("Add sound ${sound?.filename}");
    sounds.add(sound);
    print("These are the sounds: ${sounds.map((e) => "${e.filename}, ")}");
    _play();
  }
}