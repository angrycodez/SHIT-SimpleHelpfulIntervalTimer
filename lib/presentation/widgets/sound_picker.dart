import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:simple_interval_timer/presentation/widgets/list_entry.dart';

import '../../core/services/preview_audio_service.dart';
import '../../core/theme/theme_constants.dart';
import '../../data/models/models.dart';

class SoundPicker extends StatelessWidget {
  final Sound? sound;
  final Function(Sound?) onSoundSelected;
  const SoundPicker({super.key, this.sound, required this.onSoundSelected,});
  @override
  Widget build(BuildContext context) {
    return ListEntry(
      onTap: () async =>
          onSoundSelected(await _pickSound(context, context.read<SettingsCubit>().state.sounds)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sound != null ? MyIcons.soundIcon : MyIcons.addSoundIcon,
          Text(sound?.filename ?? "Select Sound"),
        ],
      ),
    );
  }

  Future<Sound?> _pickSound(BuildContext context, List<Sound> sounds) async {
    PreviewAudioService audioService = PreviewAudioService();
    var result = await showDialog<Sound?>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Sound'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text('No Sound'),
            ),
            ...sounds
                .map(
                  (sound) => SimpleDialogOption(
                    onPressed: () => Navigator.of(context).pop(sound),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        MyIcons.soundIcon,
                        Text(sound.filename),
                      ],),
                      IconButton(onPressed: ()=>audioService.play(sound), icon: MyIcons.soundPreviewIcon,),
                    ],
                    ),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
    return result;
  }
}
