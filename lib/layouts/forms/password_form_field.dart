import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordFormField extends StatefulWidget {
  PasswordFormField(
      {super.key, required this.handleOnSaved, required this.onChanged});

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();

  bool isPasswordVisible = false;
  final Function(String?) handleOnSaved;
  final Function(String?) onChanged;
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onSaved: widget.handleOnSaved,
          onChanged: widget.onChanged,
          obscureText: !widget.isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Mot de passe',
            suffixIcon: IconButton(
              icon: Icon(
                widget.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
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
