import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    this.errorText,
    this.initialValue,
    this.handleOnSaved,
    this.hideInput,
    this.inputFormatters,
    this.keyboardType,
    required this.label,
    this.maxLines,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  final String? errorText;
  final String? initialValue;
  final bool? hideInput;
  final Function(String?)? handleOnSaved;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String label;
  final int? maxLines;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        onSaved: handleOnSaved,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        obscureText: hideInput ?? false,
        decoration: InputDecoration(errorText: errorText, labelText: label),
      ),
    );
  }
}
