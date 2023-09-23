import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';


class SettingsSelectionEntry extends StatelessWidget {
  final String name;
  final Widget child;
  const SettingsSelectionEntry({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(name, style: Theme.of(context).textTheme.displaySmall,)),
        const SizedBox(width: Layout.defaultHorizontalSpace,),
        Expanded(flex: 3, child: child),
      ],
    );
  }
}

