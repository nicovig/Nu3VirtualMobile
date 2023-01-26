import 'package:flutter/material.dart';

class CustomFormFieldTime extends StatelessWidget {
  CustomFormFieldTime({
    Key? key,
    this.initialValue,
    required this.hoursDisplayed,
    required this.minutesDisplayed,
    required this.handleOnChanged,
    required this.label,
  }) : super(key: key);

  final Function(TimeOfDay?) handleOnChanged;
  final String? initialValue;
  final String? label;
  final int hoursDisplayed;
  final int minutesDisplayed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            showCursor: true,
            readOnly: true,
            initialValue: '${hoursDisplayed}h ${minutesDisplayed}min',
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.access_time_rounded),
              labelText: label,
            ),
            onTap: (() async {
              final time =
                  await _pickTime(context, hoursDisplayed, minutesDisplayed);
              handleOnChanged(time);
            })));
  }

  Future<TimeOfDay?> _pickTime(
          BuildContext context, int hoursDisplayed, int minutesDisplayed) =>
      showTimePicker(
          context: context,
          initialTime:
              TimeOfDay(hour: hoursDisplayed, minute: minutesDisplayed));
}
