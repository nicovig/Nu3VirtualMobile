import 'package:flutter/material.dart';

class CustomFormFieldTime extends StatelessWidget {
  CustomFormFieldTime({
    Key? key,
    this.initialValue,
    required this.handleOnChanged,
  }) : super(key: key);

  final Function(TimeOfDay?) handleOnChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            showCursor: true,
            readOnly: true,
            initialValue: initialValue,
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.access_time_rounded)),
            onTap: (() async {
              final time = await _pickTime(context);
              handleOnChanged(time);
            })));
  }

//
  Future<TimeOfDay?> _pickTime(BuildContext context) => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));
}
