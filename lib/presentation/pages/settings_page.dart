import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/settings_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/sounds_edit_page.dart';
import 'package:simple_interval_timer/presentation/widgets/list_entry.dart';
import 'package:simple_interval_timer/presentation/widgets/my_scaffold.dart';
import 'package:simple_interval_timer/presentation/widgets/settings_selection_entry.dart';
import 'package:simple_interval_timer/presentation/widgets/sound_picker.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => SettingsPage(key: key));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (pop) async {
        await _storeSettings(context);
      },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => MyScaffold(
          appBar: StandardComponents.getAppBar(context, "Settings"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsSelectionEntry(
                  name: "Default Interval Start Sound",
                  child: SoundPicker(
                    key: const Key("defaultIntervalStartSound"),
                    sound: state.defaultIntervalStartSound,
                    onSoundSelected: (sound) => context
                        .read<SettingsCubit>()
                        .setDefaultIntervalStartSound(sound),
                  ),
                ),
                SettingsSelectionEntry(
                  name: "Default Interval End Sound",
                  child: SoundPicker(
                    key: const Key("defaultIntervalEndSound"),
                    sound: state.defaultIntervalEndSound,
                    onSoundSelected: (sound) => context
                        .read<SettingsCubit>()
                        .setDefaultIntervalEndSound(sound),
                  ),
                ),
                SettingsSelectionEntry(
                  name: "Default Session End Sound",
                  child: SoundPicker(
                    key: const Key("defaultSessionEndSound"),
                    sound: state.defaultSessionEndSound,
                    onSoundSelected: (sound) => context
                        .read<SettingsCubit>()
                        .setDefaultSessionEndSound(sound),
                  ),
                ),
                _SubSettingsNavigationEntry(
                  title: "Sounds",
                  targetRoute: SoundsEditPage.getRoute(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _storeSettings(BuildContext context) async =>
      await context.read<SettingsCubit>().storeSettings();
}



class _SubSettingsNavigationEntry extends StatelessWidget {
  final String title;
  final MaterialPageRoute? targetRoute;

  const _SubSettingsNavigationEntry(
      {super.key, required this.title, this.targetRoute});

  @override
  Widget build(BuildContext context) {
    return ListEntry(
      onTap: targetRoute != null
          ? () => Navigator.of(context).push(targetRoute!)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          MyIcons.navigateMenuIcon,
        ],
      ),
    );
  }
}
