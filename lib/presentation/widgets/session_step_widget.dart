import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/presentation/widgets/session_block_widget.dart';
import 'package:simple_interval_timer/presentation/widgets/session_interval_widget.dart';

import '../../domain/blocs/blocs.dart';

class SessionStepWidget extends StatelessWidget {
  final SessionStepCubit sessionStepCubit;
  const SessionStepWidget(this.sessionStepCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sessionStepCubit,
      child: BlocBuilder<SessionStepCubit, SessionStepState>(
        builder: (context, state) {
          return Row(
              children: [
                if(state.isEditMode)...[
                  IconButton(
                    onPressed: ()=>sessionStepCubit.delete(),
                    icon: MyIcons.deleteIcon,
                  )
                ],
                Expanded(
                  child: GestureDetector(
                    onTap: ()=>sessionStepCubit.setEditMode(),
                    child: _getStepWidget(state),
                  ),
                ),
                if(state.isEditMode)...[
                  Column(
                    children: [
                      IconButton(
                        onPressed: ()=>sessionStepCubit.moveUp(sessionStepCubit.state.sessionStep),
                        icon: MyIcons.moveUpIcon,
                      ),
                      IconButton(
                        onPressed: ()=>sessionStepCubit.moveDown(sessionStepCubit.state.sessionStep),
                        icon: MyIcons.moveDownIcon,
                      )
                    ],
                  ),
                ]
              ],
          );
        },
      ),
    );
  }

  Widget _getStepWidget(SessionStepState state) {
    if (state.sessionStep is SessionBlock) {
      return SessionBlockWidget(
        sessionStepCubit as SessionBlockCubit,
        key: Key(sessionStepCubit.state.id),
      );
    } else if (state.sessionStep is SessionInterval) {
      return SessionIntervalWidget(
        sessionStepCubit as SessionIntervalCubit,
        key: Key(sessionStepCubit.state.id),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
