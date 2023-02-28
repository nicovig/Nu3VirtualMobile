import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/password_form_field.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_screen_viewmodel.dart';

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
        onViewModelReady: (model) {
          EasyLoading.show();
          model.setData();
          EasyLoading.dismiss(animation: false);
        },
        builder: (context, model, child) => Scaffold(
            appBar:
                CustomAppBar(title: title, displayDisconnectionButton: false),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const CustomTitle(title: "Se connecter"),
                      CustomFormField(
                          onChanged: (value) => model.login = value!,
                          label: 'Pseudo ou email'),
                      PasswordFormField(
                        label: 'Mot de passe',
                        onChanged: (value) => model.password = value!,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color_4),
                          ),
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color_4),
                          ),
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
