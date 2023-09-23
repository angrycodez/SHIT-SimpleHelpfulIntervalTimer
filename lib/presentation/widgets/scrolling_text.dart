
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class ScrollingText extends StatelessWidget{
  final String _text;
  final TextStyle? style;

  const ScrollingText(this._text,{super.key, this.style,});

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      _text,
      mode: TextScrollMode.endless,
      pauseBetween: const Duration(seconds: 1),
      intervalSpaces: 5,
      velocity: const Velocity(pixelsPerSecond: Offset(80,0)),
      style: style ?? Theme.of(context).textTheme.displaySmall,
    );
  }

}