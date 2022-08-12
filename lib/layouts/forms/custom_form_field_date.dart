import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';

class CustomFormFieldDate extends StatelessWidget {
  CustomFormFieldDate(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      required this.handleOnSaved,
      required this.label})
      : super(key: key);

  final Function(DateTime?) handleOnSaved;
  final DateTime firstDate;
  final String label;
  final DateTime lastDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateTimeFormField(
        onDateSelected: handleOnSaved,
        dateFormat: DateFormat('dd MM yyyy'),
        firstDate: firstDate,
        lastDate: lastDate,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black45),
          errorStyle: const TextStyle(color: Colors.redAccent),
          suffixIcon: const Icon(Icons.event_note),
          labelText: label,
        ),
        mode: DateTimeFieldPickerMode.date,
      ),
    );
  }
}
