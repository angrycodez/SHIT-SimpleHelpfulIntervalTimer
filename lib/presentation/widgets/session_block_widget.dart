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
        borderColor: blockCubit.state.isSelected ? MyColors.cardEditBorderColor : MyColors.cardBorderColor,
      ),
      child: block.isEditMode
        ? SessionBlockEditWidget(blockCubit)
        : SessionBlockInfoWidget(blockCubit),
    );
  }
}


class SessionBlockInfoWidget extends StatelessWidget {
  final SessionBlockCubit blockCubit;
  const SessionBlockInfoWidget(this.blockCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionBlockState block = blockCubit.state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(block.name ?? ""),
            Text(block.duration.toString()),
            Text(block.repetitions.toString()),
            const SizedBox.shrink(),
          ],
        ),
        SessionBlockChildrenWidget(children: block.children),
      ],
    );
  }
}

class SessionBlockEditWidget extends StatelessWidget {
  final SessionBlockCubit blockCubit;
  const SessionBlockEditWidget(this.blockCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionBlockState block = blockCubit.state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            nameTextField(),
            Text(block.duration.toString()),
            repetitionsTextField(),
            const SizedBox.shrink(),
          ],
        ),
        SessionBlockChildrenWidget(children: block.children),
      ],
    );
  }

  Widget nameTextField(){
    return SizedBox(
      width: 100,
      child: TextFormField(
        initialValue: blockCubit.state.name ?? "",
        decoration: const InputDecoration(
          helperText: "Name",
        ),
        onChanged: (newValue) => blockCubit.setName(newValue),
      ),
    );
  }
  Widget repetitionsTextField(){
    return SizedBox(
      width: 100,
      child: TextFormField(
        initialValue: blockCubit.state.repetitions.toString() ?? "",
        keyboardType: const TextInputType.numberWithOptions(),
        decoration: const InputDecoration(
          helperText: "Repetitions",
        ),
        onChanged: (newValue) => blockCubit.setRepetitions(int.parse(newValue)),
      ),
    );
  }
}


class SessionBlockChildrenWidget extends StatelessWidget{
  final List<SessionStepCubit> children;

  const SessionBlockChildrenWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Layout.cardPadding,
      margin: Layout.cardMargin,
      child: Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: children.length,
          itemBuilder: (context, index) {
            SessionStepCubit step = children[index];
            return SessionStepWidget(
              step,
              key: Key(step.state.id),
            );
          },
        ),
      ),
    );
  }

}
