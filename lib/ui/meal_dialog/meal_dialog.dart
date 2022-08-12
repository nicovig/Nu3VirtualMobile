import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';

class MealDialog extends StatelessWidget {
  MealDialog({required this.handleValidation});

  final Function(String?)? handleValidation;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text(
          "Créer un repas",
          textAlign: TextAlign.center,
        ),
        children: [
          CustomFormField(handleOnSaved: (value) => null, hintText: 'Nom'),
          CustomFormField(handleOnSaved: (value) => null, hintText: 'Date'),
          CustomFormField(handleOnSaved: (value) => null, hintText: 'Glucides'),
          CustomFormField(handleOnSaved: (value) => null, hintText: 'Lipides'),
          CustomFormField(
              handleOnSaved: (value) => null, hintText: 'Protéines'),
          CustomFormField(handleOnSaved: (value) => null, hintText: 'Calories'),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
                onPressed: () {
                  handleValidation;
                },
                child: const Text("Ajouter")),
          ),
        ]);
  }
}
