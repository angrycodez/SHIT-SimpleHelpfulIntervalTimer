import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';
import 'package:simple_interval_timer/presentation/widgets/list_entry.dart';

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
    return await showDialog<Sound?>(
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
                  (e) => SimpleDialogOption(
                    onPressed: () => Navigator.of(context).pop(e),
                    child: Text(e.filename),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}