import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/helper/constants.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

import '../widgets/widets.dart';

class SessionPage extends StatelessWidget {
  final SessionCubit sessionCubit;
  const SessionPage(this.sessionCubit, {super.key});

  static MaterialPageRoute getRoute(SessionCubit session, {Key? key}) {
    return MaterialPageRoute(
      builder: (context) => SessionPage(
        session,
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (sessionCubit.state.hasChanges) {
          await sessionCubit.storeSession(
              context.read<SessionDatabaseCubit>().sessionRepository);
        }
        return true;
      },
      child: BlocProvider.value(
        value: sessionCubit,
        child:
            BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
          return GestureDetector(
            onTap: () => sessionCubit.deselectAll(),
            child: MyScaffold(
              appBar: StandardComponents.getAppBar(context, state.name),
              body: Container(
                margin: Layout.defaultPageContentMargin,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: state.name,
                              maxLength: maxNameLength,
                              decoration: const InputDecoration(
                                helperText: "Name",
                              ),
                              onChanged: (newValue) => sessionCubit.setName(newValue),
                            ),
                            TextFormField(
                              initialValue: state.description,
                              maxLength: sessionDescriptionLength,
                              minLines: 1,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                helperText: 'Description',
                              ),
                              onChanged: (newValue) =>
                                  sessionCubit.setDescription(newValue),
                            ),
                            SettingsSelectionEntry(
                              name: "End Sound",
                              child: SoundPicker(
                                key: const Key("EndSound"),
                                sound: state.endSound,
                                onSoundSelected: (sound) =>
                                    sessionCubit.setEndSound(sound),
                              ),
                            ),
                              Container(
                                padding: Layout.cardPadding,
                                margin: Layout.defaultVerticalSpacing,
                                decoration: MyDecoration.cardDecoration(context, color: Colors.transparent, borderColor: MyColors.cardBackgroundColor,),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.steps.length,
                                  itemBuilder: (context, index) {
                                    SessionStepCubit step = state.steps[index];
                                    return SessionStepWidget(
                                      step,
                                      key: Key(step.state.id),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    _bottomControlsBar(context, state),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _bottomControlsBar(BuildContext context, SessionState state) {
    if (state.selectedStep is SessionIntervalCubit) {
      return SessionIntervalEditControlsWidget(
        state.selectedStep as SessionIntervalCubit,
        key: Key("${state.selectedStep!.state.id}_edit_controls"),
      );
    } else if (state.selectedStep is SessionBlockCubit) {
      return SessionBlockEditControlsWidget(
        state.selectedStep as SessionBlockCubit,
        key: Key("${state.selectedStep!.state.id}_edit_controls"),
      );
    }
    return SessionEditControlsWidget(
      context.read<SessionCubit>(),
      key: Key("${state.id}_edit_controls"),
    );
  }
}
