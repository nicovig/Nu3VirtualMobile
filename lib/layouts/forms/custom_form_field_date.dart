import 'package:flutter/material.dart';

import 'package:date_field/date_field.dart';
import 'package:intl/src/intl/date_format.dart';

import 'package:nu3virtual/core/const/colors.dart';

class CustomFormFieldDate extends StatelessWidget {
  CustomFormFieldDate(
      {Key? key,
      this.firstDate,
      this.initialValue,
      this.lastDate,
      required this.handleOnSaved,
      required this.label})
      : super(key: key);

  final Function(DateTime?) handleOnSaved;
  final DateTime? firstDate;
  final String label;
  final DateTime? lastDate;
  final DateTime? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateTimeFormField(
        initialValue: initialValue,
        onDateSelected: handleOnSaved,
        dateFormat: DateFormat('dd MM yyyy'),
        firstDate: firstDate,
        lastDate: lastDate,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.event_note),
          focusColor: color_3,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: color_3,
              width: 1.0,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
        ),
        mode: DateTimeFieldPickerMode.date,
      ),
    );
  }
}
