import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

import '../../core/theme/theme_constants.dart';
import '../../data/models/models.dart';
import '../widgets/widets.dart';

class SoundsEditPage extends StatelessWidget {
  const SoundsEditPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => SoundsEditPage(key: key));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SoundsEditCubit(context.read<SessionDatabaseCubit>()),
      child: BlocBuilder<SoundsEditCubit, SoundsEditState>(
        builder: (context, soundEditState) =>
            BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) => MyScaffold(
            appBar: StandardComponents.getAppBar(context, "Sounds"),
            body: Column(
              children: [
                const _NewSoundButton(),
                Expanded(
                  child: ListView.builder(
                    itemCount: settingsState.sounds.length,
                    itemBuilder: (context, index) => _soundEntry(
                      context,
                      settingsState.sounds[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _soundEntry(BuildContext context, Sound sound) {
    return ListEntry(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyIcons.soundIcon,
              Text(sound.filename),
            ],
          ),
          IconButton(
            onPressed: () => context.read<SettingsCubit>().deleteSound(sound),
            icon: MyIcons.deleteIcon,
          ),
        ],
      ),
    );
  }
}

class _NewSoundButton extends StatelessWidget {
  const _NewSoundButton();

  @override
  Widget build(BuildContext context) {
    return ListEntry(
      onTap: () => _pickFile(context.read<SettingsCubit>()),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Import new Sound"),
          MyIcons.addSoundIcon,
        ],
      ),
    );
  }

  Future _pickFile(SettingsCubit settingsCubit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );
    if (result == null) {
      return;
    }
    var file = result.files.single;
    if (file.path == null) {
      return;
    }
    await settingsCubit.addSoundFile(file);
  }
}
