import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/user_screen/user_screen_viewmodel.dart';
import 'package:nu3virtual/core/helper-classes/ext-classes.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';

class UserScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  String lastname = '';
  String firstname = '';
  String pseudo = '';
  int height = 0;
  double weight = 0;
  String email = '';
  int phone = 0;
  String password = '';
  DateTime dateTime = DateTime.now();

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
                            RegExp('[a-zA-Z]'),
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
                            RegExp(r"[a-zA-Z]+|\s"),
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
                            RegExp('[0-9]'),
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val != null && !val.isValidName) {
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
                            RegExp('[0-9]'),
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val != null && !val.isValidName) {
                            return 'Veuillez entrer un poids valide';
                          }
                        },
                      ),
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
                          if (value != null) phone = int.parse(value);
                        },
                        hintText: 'Téléphone',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          )
                        ],
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val != null && !val.isValidPhone) {
                            return 'Veuillez entrer un téléphone valide';
                          }
                        },
                      ),
                      CustomFormField(
                        handleOnSaved: (value) {
                          if (value != null) password = value;
                        },
                        hintText: 'Mot de passe',
                        validator: (val) {
                          if (val != null && !val.isValidPassword) {
                            return 'Veuillez entrer un mot de passe valide';
                          }
                        },
                      ),
                      //'Date de naissance'
                      // Row(
                      //   children: [
                      //     Text('Date de naissance' + dateTime.toString() != null
                      //         ? dateTime.toString()
                      //         : ''),
                      //     Container(margin: const EdgeInsets.only(right: 20)),
                      //     ElevatedButton(
                      //         onPressed: () async {
                      //           showDatePicker(
                      //               context: context,
                      //               initialDate: dateTime,
                      //               firstDate: DateTime(1900),
                      //               lastDate: DateTime.now());
                      //         },
                      //         child: const Text('Select date')),
                      //   ],
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          //if (formKey.currentState!.validate()) {
                          // model.createUser(
                          //     lastname: lastname,
                          //     firstname: firstname,
                          //     pseudo: pseudo,
                          //       height: height,
                          //     weight: weight,
                          //     email: email,
                          //     phone: phone,
                          //     password: password);

                          model.createUser(
                              lastname: 'Vigouroux',
                              firstname: 'Nicolas',
                              pseudo: 'koalaviril',
                              height: '168',
                              weight: '75.5',
                              email: 'koalaviril@gmail.com',
                              phone: '0606060606',
                              password: 'password');
                          //}
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
