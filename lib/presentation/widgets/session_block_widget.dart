import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/helper/constants.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/presentation/widgets/duration_info.dart';
import 'package:simple_interval_timer/presentation/widgets/repetition_info.dart';
import 'package:simple_interval_timer/presentation/widgets/scrolling_text.dart';
import 'package:simple_interval_timer/presentation/widgets/session_step_widget.dart';

import '../../domain/blocs/blocs.dart';

class SessionBlockWidget extends StatelessWidget {
  final SessionBlockCubit blockCubit;
  const SessionBlockWidget(this.blockCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionBlockState block = blockCubit.state;
    return Container(
      padding: Layout.sessionBlockPadding,
      decoration: MyDecoration.cardDecoration(
        context,
        color: MyColors.sessionBlockBackgroundColor,
        borderColor:
            blockCubit.state.isSelected ? MyColors.cardEditBorderColor : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          block.isEditMode
              ? SessionBlockEditWidget(blockCubit)
              : SessionBlockInfoWidget(blockCubit),
          SessionBlockChildrenWidget(children: block.children),
        ],
      ),
    );
  }
}

class SessionBlockInfoWidget extends StatelessWidget {
  final SessionBlockCubit blockCubit;
  const SessionBlockInfoWidget(this.blockCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    SessionBlockState block = blockCubit.state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _blockNameInfo(context)),
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DurationInfo(block.duration),
            const SizedBox(width: Layout.defaultHorizontalSpace * 2),
            RepetitionInfo(block.repetitions),
          ],
        ),
        const SizedBox(width: Layout.defaultHorizontalSpace),
      ],
    );
  }

  Widget _blockNameInfo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyIcons.sessionBlockIcon,
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Expanded(
            child: ScrollingText(
          blockCubit.state.name,
          style: Theme.of(context).textTheme.displaySmall,
        )),
        const SizedBox(width: Layout.defaultHorizontalSpace),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: nameTextField()),
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            DurationInfo(block.duration),
            const SizedBox(width: Layout.defaultHorizontalSpace * 2),
            repetitionsTextField(),
          ],
        ),
        const SizedBox(width: Layout.defaultHorizontalSpace),
      ],
    );
  }

  Widget nameTextField() {
    return SizedBox(
      width: 100,
      child: TextFormField(
        initialValue: blockCubit.state.name,
        maxLength: maxNameLength,
        decoration: const InputDecoration(
          icon: MyIcons.sessionBlockIcon,
          counterText: "",
        ),
        onChanged: (newValue) => blockCubit.setName(newValue),
      ),
    );
  }

  Widget repetitionsTextField() {
    return SizedBox(
      width: 80,
      child: TextFormField(
        initialValue: blockCubit.state.repetitions.toString(),
        keyboardType: const TextInputType.numberWithOptions(),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 2,
        decoration: const InputDecoration(
          icon: MyIcons.restartIntervalIcon,
          counterText: "",
        ),
        onChanged: (newValue) {
          int repetitions = int.tryParse(newValue) ?? 0;
          blockCubit.setRepetitions(repetitions);
        },
      ),
    );
  }
}

class SessionBlockChildrenWidget extends StatelessWidget {
  final List<SessionStepCubit> children;

  const SessionBlockChildrenWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Layout.cardPadding,
      margin: Layout.sessionBlockChildMargin,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: children.length,
        itemBuilder: (context, index) {
          SessionStepCubit step = children[index];
          return SessionStepWidget(
            step,
            key: Key(step.state.id),
          );
        },
      ),
    );
  }
}
