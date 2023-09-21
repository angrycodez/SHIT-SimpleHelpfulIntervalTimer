

import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import '../../data/models/models.dart';

class AudioService{
  late AudioPlayer _player;
  final List<Sound> sounds = List.empty(growable: true);

  StreamSubscription? completeListener;

  AudioService(){
    _player = AudioPlayer();
    completeListener = _player.onPlayerComplete.listen(_onPlayerComplete);
  }

  Future dispose() async {
    await _player.dispose();
    await completeListener?.cancel();
  }

  void _onPlayerComplete(void _){
    _play();
  }

  bool canPlaySound(){
    return _player.state != PlayerState.playing;
  }

  void _play(){
    if(sounds.isEmpty){
      _player.stop();
      return;
    }
    if(canPlaySound()){
      String path = sounds.first.filepath;
      if(!File(path).existsSync()){
        return;
      }
      sounds.removeAt(0);
      lastSoundPlayed = DateTime.now();
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
    sounds.add(sound);
    _play();
  }
}