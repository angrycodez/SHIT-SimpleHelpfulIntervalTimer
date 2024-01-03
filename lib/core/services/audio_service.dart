

import 'package:simple_interval_timer/core/services/ap_audio_service.dart';
import 'package:simple_interval_timer/core/services/ja_audio_service.dart';

import '../../data/models/models.dart';
import '../helper/platform.dart';

abstract class AudioService{
  Future dispose();
  Future play(Sound? sound);
  Future stop();

  static AudioService get(){
    if(isMobile()){
      return JAAudioService();
    }else{
      return APAudioService();
    }
  }
}