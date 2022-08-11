import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/user_screen/user_screen_viewmodel.dart';
import 'package:nu3virtual/core/helpers/ext-classes.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';

class UserScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String lastname = '';
  String firstname = '';
  String pseudo = '';
  int height = 0;
  double weight = 0;
  String email = '';
  String password = '';
  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserScreenViewModel>.reactive(
        viewModelBuilder: () => UserScreenViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text("NuVirtual"),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTitle(title: "Créer un compte"),
                      CustomFormField(
                        handleOnSaved: (value) {
                          if (value != null) lastname = value;
                        },
                        hintText: 'Nom',
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
                        handleOnSaved: (value) {
                          if (value != null) firstname = value;
                        },
                        hintText: 'Prénom',
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
                        handleOnSaved: (value) {
                          if (value != null) pseudo = value;
                        },
                        hintText: 'Pseudo',
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
                        handleOnSaved: (value) {
                          if (value != null) height = int.parse(value);
                        },
                        hintText: 'Taille (en cm)',
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
                        handleOnSaved: (value) {
                          if (value != null) weight = double.parse(value);
                        },
                        hintText: 'Poids (en kg)',
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
                      CustomFormFieldDate(handleOnSaved: (value) {
                        if (value != null) birthday = value;
                      }),
                      CustomFormField(
                        handleOnSaved: (value) {
                          if (value != null) email = value;
                        },
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val != null && !val.isValidEmail) {
                            return 'Veuillez entrer un mail valide';
                          }
                        },
                      ),
                      CustomFormField(
                        handleOnSaved: (value) {
                          if (value != null) password = value;
                        },
                        hintText: 'Mot de passe',
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
