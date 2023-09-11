

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget{
  final String initialValue;
  final Function(String) updateValue;
  const MyTextField(this.updateValue, {super.key, this.initialValue = ""});

  @override
  State<StatefulWidget> createState() => MyTextFieldState();

}

class MyTextFieldState extends State<MyTextField>{

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: textEditingController,);
  }

}