import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nu3virtual/core/const/colors.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    this.errorText,
    this.initialValue,
    this.handleOnSaved,
    this.hideInput,
    this.hideBorder,
    this.inputFormatters,
    this.keyboardType,
    required this.label,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  final String? errorText;
  final String? initialValue;
  final bool? hideInput;
  final bool? hideBorder;
  final Function(String?)? handleOnSaved;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String label;
  final int? maxLines;
  final int? maxLength;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: color_4,
        initialValue: initialValue,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        onSaved: handleOnSaved,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        obscureText: hideInput ?? false,
        decoration: InputDecoration(
          focusColor: color_4,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: color_4,
              width: 1.0,
            ),
          ),
          errorText: errorText,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          border: hideBorder == true ? InputBorder.none : null,
        ),
      ),
    );
  }
}
