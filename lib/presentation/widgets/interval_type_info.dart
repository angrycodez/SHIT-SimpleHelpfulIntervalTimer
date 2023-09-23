
import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class IntervalTypeInfo extends StatelessWidget{
  final bool _isPause;

  const IntervalTypeInfo(this._isPause, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_isPause) ...[
          MyIcons.pauseIcon
        ] else ...[
          MyIcons.workIcon
        ],
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Text(
          _isPause ? "Pause" : "Work",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }

}