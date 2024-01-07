import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/constants.dart';
import 'package:simple_interval_timer/core/helper/platform.dart';

import '../../core/theme/theme_constants.dart';
import '../../domain/blocs/blocs.dart';
import '../widgets/widets.dart';

class SessionIntervalEditPage extends StatelessWidget {
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalEditPage(this.intervalCubit, {super.key});

  static MaterialPageRoute getRoute(SessionIntervalCubit intervalCubit,
      [Key? key]) {
    return MaterialPageRoute(
        builder: (context) => SessionIntervalEditPage(intervalCubit));
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: StandardComponents.getAppBar(context, intervalCubit.state.name),
      body: BlocProvider.value(
        value: intervalCubit,
        child: BlocBuilder<SessionIntervalCubit, SessionStepState>(
          builder: (context, interval) => interval is SessionIntervalState
              ? Container(
                  margin: Layout.defaultContentMargin,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameTextField(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DurationTextField(
                              initalDuration: interval.duration,
                              updateDuration: (duration) =>
                                  intervalCubit.setDuration(duration),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                margin: Layout.defaultContentMargin,
                                child: MyColorPicker(
                                  color: interval.color,
                                  onColorChanged: (color) =>
                                      intervalCubit.setColor(color),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: interval.isPause,
                                onChanged: (newValue) =>
                                    intervalCubit.setIsPause(newValue)),
                            if (interval.isPause) ...[
                              const Text("Pause"),
                              const SizedBox(
                                  width: Layout.defaultHorizontalSpace),
                              MyIcons.pauseIcon
                            ] else ...[
                              const Text("Work"),
                              const SizedBox(
                                  width: Layout.defaultHorizontalSpace),
                              MyIcons.workIcon
                            ]
                          ],
                        ),
                        SettingsSelectionEntry(
                          name: "Start Sound",
                          child: SoundPicker(
                            key: const Key("StartSound"),
                            sound: interval.startSound,
                            onSoundSelected: (sound) =>
                                intervalCubit.setStartSound(sound),
                          ),
                        ),
                        if (isDesktop()) ...[
                          _commandTextField(),
                        ],
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      initialValue: intervalCubit.state.name,
      maxLength: maxNameLength,
      decoration: const InputDecoration(
        helperText: "Name",
      ),
      onChanged: (newValue) => intervalCubit.setName(newValue),
    );
  }

  Widget _commandTextField() {
    return TextFormField(
      initialValue: intervalCubit.state.startCommand,
      decoration: const InputDecoration(
        helperText: "Command",
      ),
      onChanged: (command) => intervalCubit.setStartCommand(command),
    );
  }
}
