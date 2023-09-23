
import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class RepetitionInfo extends StatelessWidget{
  final int _repetitions;

  const RepetitionInfo(this._repetitions, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyIcons.restartIntervalIcon,
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Text(_repetitions.toString(), style: Theme.of(context).textTheme.displaySmall,),
      ],
    );
  }

}