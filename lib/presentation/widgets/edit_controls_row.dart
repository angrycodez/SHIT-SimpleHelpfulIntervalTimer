import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class EditControlsRow extends StatelessWidget {
  final List<IconButton> actions;

  const EditControlsRow({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      /*margin: const EdgeInsets.only(
        left: Layout.defaultHorizontalSpace,
        right: Layout.defaultHorizontalSpace,
      ),*/
      decoration: BoxDecoration(
        color: MyColors.lightCardBackgroundColor,
        border: Border.all(
          color: MyColors.cardBorderColor,
          width: Layout.borderWidth,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Layout.defaultBorderRadius,
          topRight: Layout.defaultBorderRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions,
      ),
    );
  }
}
