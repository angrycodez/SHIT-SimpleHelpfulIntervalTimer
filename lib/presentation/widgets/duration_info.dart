
import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

import '../../core/helper/converter.dart';

class DurationInfo extends StatelessWidget{
  final Duration _duration;

  const DurationInfo(this._duration, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyIcons.durationIcon,
        const SizedBox(width: Layout.defaultHorizontalSpace),
        Text(TypeConverter.durationToString(_duration), style: Theme.of(context).textTheme.displaySmall,),
      ],
    );
  }

}