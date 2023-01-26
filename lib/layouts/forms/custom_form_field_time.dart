import 'package:flutter/material.dart';

class CustomFormFieldTime extends StatelessWidget {
  const CustomFormFieldTime({
    Key? key,
    required this.initialTime,
    required this.handleOnChanged,
    required this.label,
  }) : super(key: key);

  final Function(TimeOfDay?) handleOnChanged;
  final TimeOfDay initialTime;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            key: Key(initialTime.toString()),
            initialValue: '${initialTime.hour}h ${initialTime.minute}min',
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.access_time_rounded),
                labelText: label),
            onTap: (() async {
              final time = await showTimePicker(
                  context: context, initialTime: initialTime);
              handleOnChanged(time);
            })));
  }
}
