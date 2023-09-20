import 'package:flutter/material.dart';


class SettingsSelectionEntry extends StatelessWidget {
  final String name;
  final Widget child;
  const SettingsSelectionEntry({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(name)),
        Expanded(flex: 4, child: child),
      ],
    );
  }
}

