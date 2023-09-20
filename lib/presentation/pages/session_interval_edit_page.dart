
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme_constants.dart';
import '../../domain/blocs/blocs.dart';
import '../widgets/widets.dart';

class SessionIntervalEditPage extends StatelessWidget{
  final SessionIntervalCubit intervalCubit;
  const SessionIntervalEditPage(this.intervalCubit, {super.key});

  static MaterialPageRoute getRoute(SessionIntervalCubit intervalCubit, [Key? key]){
    return MaterialPageRoute(builder: (context) => SessionIntervalEditPage(intervalCubit));
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: StandardComponents.getAppBar(context, intervalCubit.state.name),
      body: BlocProvider.value(
        value: intervalCubit,
        child: BlocBuilder<SessionIntervalCubit, SessionStepState>(
          builder: (context, interval) => interval is SessionIntervalState
          ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameTextField(),
                DurationTextField(
                  initalDuration: interval.duration,
                  updateDuration: (duration) => intervalCubit.setDuration(duration),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: interval.isPause,
                        onChanged: (newValue) => intervalCubit.setIsPause(newValue)),
                    const Text("Pause"),
                    if (interval.isPause) ...[
                      MyIcons.pauseIcon
                    ] else ...[
                      MyIcons.workIcon
                    ]
                  ],
                ),
                SettingsSelectionEntry(
                  name: "Start Sound",
                  child: SoundPicker(
                    key: const Key("StartSound"),
                    sound: interval.startSound,
                    onSoundSelected: (sound) => intervalCubit.setStartSound(sound),
                  ),
                ),
                SettingsSelectionEntry(
                  name: "End Sound",
                  child: SoundPicker(
                    key: const Key("EndSound"),
                    sound: interval.endSound,
                    onSoundSelected: (sound) =>
                        intervalCubit.setEndSound(sound),
                  ),
                ),
              ],
            ),
          )
      : const SizedBox.shrink(),
        ),
      ),
    );
  }


  Widget _nameTextField() {
    return SizedBox(
      width: 400,
      child: TextFormField(
        initialValue: intervalCubit.state.name ?? "",
        maxLength: 128,
        decoration: const InputDecoration(
          helperText: "Name",
        ),
        onChanged: (newValue) => intervalCubit.setName(newValue),
      ),
    );
  }
  
}