import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmationDialog(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(false),
          icon: MyIcons.cancelIcon,
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(true),
          icon: MyIcons.acceptIcon,
        ),
      ],
    );
  }

  static Future<bool> askForConfirmation(
    BuildContext context,
    String title,
    String content,
  ) async {
    bool? isConfirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(title: title, content: content),
    );
    return isConfirmed ?? false;
  }
}
