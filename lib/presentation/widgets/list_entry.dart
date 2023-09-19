
import 'package:flutter/material.dart';

import '../../core/theme/theme_constants.dart';

class ListEntry extends StatelessWidget{
  final Widget child;
  final Function()? onTap;
  const ListEntry({super.key, required this.child, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: Layout.cardMargin,
        padding: Layout.cardPadding,
        decoration: MyDecoration.cardDecoration(context),
        child: child,
      ),
    );
  }

}