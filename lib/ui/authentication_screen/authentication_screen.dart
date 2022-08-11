import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';

class AuthenticationScreen extends StatelessWidget {
  //constructor
  AuthenticationScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationScreenViewModel>.reactive(
        viewModelBuilder: () => AuthenticationScreenViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTitle(title: "Créer un compte"),
                      CustomFormField(
                          handleOnSaved: (value) => _checkEmailOrPseudo(value),
                          hintText: 'Pseudo ou email'),
                      CustomFormField(
                          handleOnSaved: (value) => _checkPassword(value),
                          hintText: 'Mot de passe'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              model.login();
                            }
                          },
                          child: const Text('Se connecter'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text("Pas encore de compte ?"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            model.createAccount(context);
                          },
                          child: const Text("Créer un compte"))
                    ],
                  ),
                ),
              ),
            )));
  }

  _checkEmailOrPseudo(String? input) {
    print(input);
  }

  _checkPassword(String? input) {
    print(input);
  }
}
