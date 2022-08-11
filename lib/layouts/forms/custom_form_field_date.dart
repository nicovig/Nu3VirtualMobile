import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';

class CustomFormFieldDate extends StatelessWidget {
  CustomFormFieldDate({Key? key, required this.handleOnSaved})
      : super(key: key);

  final Function(DateTime?) handleOnSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateTimeFormField(
        onDateSelected: handleOnSaved,
        dateFormat: DateFormat('dd-MM-yyyy'),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black45),
          errorStyle: TextStyle(color: Colors.redAccent),
          suffixIcon: Icon(Icons.event_note),
          labelText: 'Date de naissance',
        ),
        mode: DateTimeFieldPickerMode.date,
      ),
    );
  }
}
