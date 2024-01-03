

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class MyColorPicker extends StatelessWidget{
  final Color color;
  final Function(Color) onColorChanged;

  const MyColorPicker({super.key, required this.color, required this.onColorChanged,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await _pickColor(context),
      child: Container(
        margin: Layout.defaultContentMargin,
        child: DecoratedBox(decoration: BoxDecoration(color: color),),
      ),
    );
  }

  Future _pickColor(BuildContext context)async{
    return await showDialog(builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ), context: context,
    );
  }
}