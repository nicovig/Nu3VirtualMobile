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
                      const CustomTitle(title: "Se connecter"),
                      CustomFormField(
                          onChanged: (value) =>
                              model.checkEmailOrPseudo(value ?? ''),
                          handleOnSaved: (value) =>
                              model.checkEmailOrPseudo(value ?? ''),
                          hintText: 'Pseudo ou email'),
                      CustomFormField(
                          onChanged: (value) =>
                              model.checkPassword(value ?? ''),
                          handleOnSaved: (value) =>
                              model.checkPassword(value ?? ''),
                          hideInput: true,
                          hintText: 'Mot de passe'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var message = await model.connect(context);
                              if (message != '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
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
