import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/colors.dart';

class PasswordFormField extends StatefulWidget {
  PasswordFormField({super.key, required this.label, required this.onChanged});

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();

  bool isPasswordVisible = false;
  String label;
  final Function(String?) onChanged;
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: widget.onChanged,
          obscureText: !widget.isPasswordVisible,
          decoration: InputDecoration(
            focusColor: color_3,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: color_3,
                width: 1.0,
              ),
            ),
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey.shade600),
            suffixIcon: IconButton(
              icon: Icon(
                widget.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color:
                    widget.isPasswordVisible ? color_3 : Colors.grey.shade400,
              ),
              onPressed: () {
                setState(() {
                  widget.isPasswordVisible = !widget.isPasswordVisible;
                });
              },
            ),
          ),
        ));
  }
}
