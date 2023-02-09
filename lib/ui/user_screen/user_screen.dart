import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_gender.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/helpers/ext-classes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/ui/user_screen/user_screen_viewmodel.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFromLogin = ModalRoute.of(context)!.settings.arguments as bool;
    return ViewModelBuilder<UserScreenViewModel>.reactive(
      viewModelBuilder: () => UserScreenViewModel(),
      builder: (context, model, child) => FutureBuilder<UserModel>(
        future: model.loadData(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) =>
            Scaffold(
          appBar: AppBar(
              title: const Text("NuVirtual"), automaticallyImplyLeading: false),
          body: SingleChildScrollView(
            child: SafeArea(
              child: snapshot.hasData
                  ? getUserForm(
                      model, context, snapshot.data ?? UserModel(), isFromLogin)
                  : const LoadingBox(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getUserForm(UserScreenViewModel model, BuildContext context,
    UserModel userFromSnapshot, bool isFromLogin) {
  UserModel user = userFromSnapshot;

  GenderEnum userGender = GenderEnum.male;

  if (user.gender == GenderEnum.male.index) {
    userGender = GenderEnum.male;
  }
  if (user.gender == GenderEnum.female.index) {
    userGender = GenderEnum.female;
  }
  if (user.gender == GenderEnum.other.index) {
    userGender = GenderEnum.other;
  }

  final formKey = GlobalKey<FormState>();
  return Form(
    key: formKey,
    child: Column(
      children: [
        const CustomTitle(title: "Créer un compte"),
        CustomFormField(
          initialValue: user.lastName,
          onChanged: (value) {
            if (value != null && value != "") user.lastName = value;
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
          initialValue: user.firstName,
          onChanged: (value) {
            if (value != null && value != "") user.firstName = value;
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
          initialValue: user.pseudo,
          onChanged: (value) {
            if (value != null && value != "") user.pseudo = value;
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
          initialValue: user.height.toString(),
          onChanged: (value) {
            if (value != null && value != "") {
              user.height = int.parse(value);
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
          initialValue: user.weight.toString(),
          onChanged: (value) {
            if (value != null && value != "") {
              user.weight = double.parse(value);
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
            initialValue: user.birthday,
            firstDate: DateTime(1900),
            label: 'Date de naissance',
            lastDate: DateTime.now(),
            handleOnSaved: (value) {
              if (value != null) user.birthday = value;
            }),
        CustomFormFieldGender(
            gender: userGender,
            handleOnPressedRadioButton: (GenderEnum value) =>
                user.gender = value.index),
        CustomFormField(
          onChanged: (value) {
            if (value != null && value != "") user.email = value;
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
            if (value != null && value != "") user.password = value;
          },
          label: 'Mot de passe',
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              model.createUser(context, user, isFromLogin);
            } else {
              EasyLoading.showError(
                  'Erreur avec les données rentrées dans le formulaire');
            }
          },
          child: const Text('Créer un compte'),
        )
      ],
    ),
  );
}
