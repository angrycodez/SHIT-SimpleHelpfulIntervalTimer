import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';

class DurationTextField extends StatefulWidget {
  final Duration initalDuration;
  final double fieldWidth;
  final void Function(Duration) updateDuration;

  const DurationTextField(
      {super.key,
      required this.initalDuration,
      required this.updateDuration,
      this.fieldWidth = Layout.durationFieldWidth});

  @override
  State<StatefulWidget> createState() => _DurationTextFieldState();
}

class _DurationTextFieldState extends State<DurationTextField> {
  late TextEditingController hoursTextEditingController;
  late TextEditingController minutesTextEditingController;
  late TextEditingController secondsTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.fieldWidth,
          child: TextFormField(
            controller: hoursTextEditingController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(counterText: ""),
          ),
        ),
        const Text(":"),
        SizedBox(
          width: widget.fieldWidth,
          child: TextFormField(
            controller: minutesTextEditingController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(counterText: ""),
          ),
        ),
        const Text(":"),
        SizedBox(
          width: widget.fieldWidth,
          child: TextFormField(
            controller: secondsTextEditingController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(counterText: "", ),
          ),
        ),
      ],
    );
  }

  void onValueChanged() {
    int hours = int.parse(hoursTextEditingController.text);
    int minutes = int.parse(minutesTextEditingController.text);
    int seconds = int.parse(secondsTextEditingController.text);
    widget.updateDuration(
      Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      ),
    );
  }

  @override
  void initState() {
    hoursTextEditingController = TextEditingController(
        text: _hoursFromDuration(widget.initalDuration).toString());
    hoursTextEditingController.addListener(onValueChanged);

    minutesTextEditingController = TextEditingController(
        text: _minutesFromDuration(widget.initalDuration).toString());
    minutesTextEditingController.addListener(onValueChanged);

    secondsTextEditingController = TextEditingController(
        text: _secondsFromDuration(widget.initalDuration).toString());
    secondsTextEditingController.addListener(onValueChanged);

    super.initState();
  }

  @override
  void dispose() {
    hoursTextEditingController.removeListener(onValueChanged);
    hoursTextEditingController.dispose();

    minutesTextEditingController.removeListener(onValueChanged);
    minutesTextEditingController.dispose();

    secondsTextEditingController.removeListener(onValueChanged);
    secondsTextEditingController.dispose();
    super.dispose();
  }

  int _hoursFromDuration(Duration d) {
    return int.parse(d.toString().split(":")[0]);
  }

  int _minutesFromDuration(Duration d) {
    return int.parse(d.toString().split(":")[1]);
  }

  int _secondsFromDuration(Duration d) {
    return int.parse(d.toString().split(".")[0].split(":")[2]);
  }
}
