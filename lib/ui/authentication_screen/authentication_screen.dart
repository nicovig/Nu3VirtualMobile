import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/password_form_field.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_forgot_password/authentication_forgot_password_dialog.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_screen_viewmodel.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationScreenViewModel>.reactive(
      viewModelBuilder: () => AuthenticationScreenViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.setDate();
        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => Scaffold(
        appBar: CustomAppBar(
            title: 'Nu3Virtual', displayDisconnectionButton: false),
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
                        backgroundColor: MaterialStateProperty.all(color_3),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(color_1)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ForgotPasswordDialog(
                            handleResetPassword: (email) async {
                              await model.resetPassword(email);
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          color: color_5,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 20, thickness: 0.8),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(color_3),
                            ),
                            onPressed: () {
                              model.createAccount(context);
                            },
                            child: const Text('Créer un compte'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
