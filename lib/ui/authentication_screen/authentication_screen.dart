import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/authentication_screen/authentication_screen_viewmodel.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/password_form_field.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';

class AuthenticationScreen extends StatelessWidget {
  //constructor
  AuthenticationScreen({Key? key, required this.title}) : super(key: key);

  bool isPasswordVisible = false;
  final String title;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationScreenViewModel>.reactive(
        viewModelBuilder: () => AuthenticationScreenViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(title),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomTitle(title: "Se connecter"),
                      CustomFormField(
                          onChanged: (value) =>
                              model.checkEmailOrPseudo(value ?? ''),
                          handleOnSaved: (value) =>
                              model.checkEmailOrPseudo(value ?? ''),
                          label: 'Pseudo ou email'),
                      PasswordFormField(
                          label: 'Mot de passe',
                          onChanged: (value) =>
                              model.checkPassword(value ?? ''),
                          handleOnSaved: (value) =>
                              model.checkPassword(value ?? '')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              EasyLoading.show();
                              var message = await model.connect(context);
                              if (message != '') {
                                EasyLoading.dismiss(animation: false);
                                EasyLoading.showError(message);
                              }
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
}
