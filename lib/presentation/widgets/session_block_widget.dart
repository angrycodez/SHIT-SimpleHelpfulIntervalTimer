import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';
import 'package:simple_interval_timer/presentation/widgets/session_step_widget.dart';

import '../../domain/blocs/blocs.dart';

class SessionBlockWidget extends StatelessWidget {
  final SessionBlockCubit blockCubit;
  const SessionBlockWidget(this.blockCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionBlockState block = blockCubit.state;
    return Container(
      margin: Layout.cardMargin,
      padding: Layout.cardPadding,
      decoration: MyDecoration.cardDecoration(
        context,
        color: Colors.lightGreenAccent,
        borderColor: blockCubit.state.isEditMode ? MyColors.cardEditBorderColor : MyColors.cardEditBorderColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(block.name ?? ""),
              Text(block.duration.toString()),
              const SizedBox.shrink(),
            ],
          ),
          Container(
            padding: Layout.cardPadding,
            margin: Layout.cardMargin,
            child: Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: block.children.length,
                itemBuilder: (context, index) {
                  SessionStepCubit step = block.children[index];
                  return SessionStepWidget(
                    step,
                    key: Key(step.state.id),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
