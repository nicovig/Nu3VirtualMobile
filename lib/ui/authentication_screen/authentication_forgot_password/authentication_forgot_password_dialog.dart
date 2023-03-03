import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/helpers/ext-classes.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({
    Key? key,
    required this.handleResetPassword,
  }) : super(key: key);

  final Function(String email) handleResetPassword;

  @override
  Widget build(BuildContext context) {
    String email = '';

    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Mot de passe oublié'),
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text('Veuillez saisir votre email'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomFormField(
            onChanged: (value) {
              if (value != null && value != "") email = value;
            },
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val != null && !val.isValidEmail) {
                return 'Veuillez entrer un mail valide';
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color_4)),
            onPressed: () {
              handleResetPassword(email);
            },
            child: const Text(
              'Envoyer un nouveau mot de passe',
            ),
          ),
        ),
      ],
    );
  }
}
