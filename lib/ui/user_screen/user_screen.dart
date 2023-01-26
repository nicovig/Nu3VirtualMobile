import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_gender.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/helpers/ext-classes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/user_screen/user_screen_viewmodel.dart';

class UserScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String lastname = '';
  String firstname = '';
  String pseudo = '';
  int height = 0;
  double weight = 0;
  GenderEnum gender = GenderEnum.male;
  String email = '';
  String password = '';
  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserScreenViewModel>.reactive(
        viewModelBuilder: () => UserScreenViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
                title: const Text("NuVirtual"),
                automaticallyImplyLeading: false),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const CustomTitle(title: "Créer un compte"),
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") lastname = value;
                        },
                        label: 'Nom',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]"),
                          )
                        ],
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val != null && !val.isValidName) {
                            return 'Veuillez entrer un nom valide';
                          }
                        },
                      ),
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") firstname = value;
                        },
                        label: 'Prénom',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]"),
                          )
                        ],
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val != null && !val.isValidName) {
                            return 'Veuillez entrer un prénom valide';
                          }
                        },
                      ),
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") pseudo = value;
                        },
                        label: 'Pseudo',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9.]'),
                          )
                        ],
                        validator: (val) {
                          if (val != null && !val.isValidPseudo) {
                            return 'Veuillez entrer un pseudo valide';
                          }
                        },
                      ),
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") {
                            height = int.parse(value);
                          }
                        },
                        label: 'Taille (en cm)',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val != null && !val.isValidNumber) {
                            return 'Veuillez entrer une taille valide';
                          }
                        },
                      ),
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") {
                            weight = double.parse(value);
                          }
                        },
                        label: 'Poids (en kg)',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9\.-]"),
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val != null && !val.isValidNumber) {
                            return 'Veuillez entrer un poids valide';
                          }
                        },
                      ),
                      CustomFormFieldDate(
                          firstDate: DateTime(1900),
                          label: 'Date de naissance',
                          lastDate: DateTime.now(),
                          handleOnSaved: (value) {
                            if (value != null) birthday = value;
                          }),
                      CustomFormFieldGender(
                          handleOnPressedRadioButton: (GenderEnum value) =>
                              gender = value),
                      CustomFormField(
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
                      CustomFormField(
                        onChanged: (value) {
                          if (value != null && value != "") password = value;
                        },
                        label: 'Mot de passe',
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            model.createUser(
                                lastname: lastname,
                                firstname: firstname,
                                pseudo: pseudo,
                                height: height,
                                weight: weight,
                                birthday: birthday,
                                gender: gender,
                                email: email,
                                password: password,
                                context: context);
                          }
                        },
                        child: const Text('Créer un compte'),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
