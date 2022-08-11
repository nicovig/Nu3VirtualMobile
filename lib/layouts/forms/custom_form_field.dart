import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    this.errorText,
    required this.handleOnSaved,
    required this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  final String? errorText;
  final String hintText;
  final Function(String?) handleOnSaved;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved: handleOnSaved,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(hintText: hintText, errorText: errorText),
      ),
    );
  }
}
