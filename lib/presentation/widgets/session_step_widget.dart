import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
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
          return GestureDetector(
            onTap: () => sessionStepCubit.setSelected(context.read<SessionCubit>()),
            child: Container(
                margin: const EdgeInsets.only(top: Layout.defaultVerticalSpace),
                child: _getStepWidget(state),
            ),
          );
        },
      ),
    );
  }

  Widget _getStepWidget(SessionStepState state) {
    if (state is SessionBlockState) {
      return SessionBlockWidget(
        sessionStepCubit as SessionBlockCubit,
        key: Key(sessionStepCubit.state.id),
      );
    } else if (state is SessionIntervalState) {
      return SessionIntervalWidget(
        sessionStepCubit as SessionIntervalCubit,
        key: Key(sessionStepCubit.state.id),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
