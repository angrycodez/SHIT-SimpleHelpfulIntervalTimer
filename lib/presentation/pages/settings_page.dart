import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/settings_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/sounds_edit_page.dart';
import 'package:simple_interval_timer/presentation/widgets/list_entry.dart';
import 'package:simple_interval_timer/presentation/widgets/my_scaffold.dart';
import 'package:simple_interval_timer/presentation/widgets/sound_picker.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => SettingsPage(key: key));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _storeSettings(context);
        return true;
      },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => MyScaffold(
          appBar: StandardComponents.getAppBar(context, "Settings"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Settings"),
                _SettingsEntry(
                  name: "Default Interval Start Sound",
                  child: SoundPicker(
                    key: const Key("defaultIntervalStartSound"),
                    sound: state.defaultIntervalStartSound,
                    onSoundSelected: (sound) => context
                        .read<SettingsCubit>()
                        .setDefaultIntervalStartSound(sound),
                  ),
                ),
                _SettingsEntry(
                  name: "Default Interval End Sound",
                  child: SoundPicker(
                    key: const Key("defaultIntervalEndSound"),
                    sound: state.defaultIntervalEndSound,
                    onSoundSelected: (sound) => context
                        .read<SettingsCubit>()
                        .setDefaultIntervalEndSound(sound),
                  ),
                ),
                _SettingsEntry(
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

class _SettingsEntry extends StatelessWidget {
  final String name;
  final Widget child;
  const _SettingsEntry({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(name)),
        Expanded(flex: 4, child: child),
      ],
    );
  }
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
