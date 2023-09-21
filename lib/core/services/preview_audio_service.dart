import 'package:audioplayers/audioplayers.dart';

import '../../data/models/models.dart';

class PreviewAudioService {
  late AudioPlayer _player;

  PreviewAudioService() {
    _player = AudioPlayer();
    _player.onPlayerComplete.listen(_onPlayerComplete);
  }

  Future dispose() async {
    await _player.dispose();
  }

  void play(Sound? sound) {
    if (sound == null) {
      return;
    }
    _player.play(
      DeviceFileSource(sound.filepath),
      mode: PlayerMode.lowLatency,
    );
  }

  void _onPlayerComplete(void _) {
    _player.stop();
  }
}
