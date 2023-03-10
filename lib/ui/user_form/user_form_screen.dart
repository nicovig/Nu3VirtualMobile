import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:date_field/date_field.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/helpers/ext-classes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_gender.dart';
import 'package:nu3virtual/layouts/forms/password_form_field.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/user_form/dialogs/change_password_dialog/change_password_dialog_screen.dart';
import 'package:nu3virtual/ui/user_form/user_form_screen_viewmodel.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFromLogin = ModalRoute.of(context)!.settings.arguments as bool;
    return ViewModelBuilder<UserScreenViewModel>.reactive(
      viewModelBuilder: () => UserScreenViewModel(),
      builder: (context, model, child) => FutureBuilder<UserModel>(
        future: model.loadData(isFromLogin),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) =>
            Scaffold(
          appBar: CustomAppBar(
              title: 'NuVirtual', displayDisconnectionButton: false),
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

  return Form(
    child: Column(
      children: [
        CustomTitle(
            title: isFromLogin ? "Créer un compte" : "Modifier mon compte"),
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
            initialValue: user.birthday ?? DateTime.now(),
            mode: DateTimeFieldPickerMode.date,
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
          initialValue: user.email,
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
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - (isFromLogin ? 0 : 70),
            child: PasswordFormField(
              label: isFromLogin ? 'Mot de passe' : 'Mot de passe en cours',
              onChanged: (value) => model.firstPassword = value!,
            ),
          ),
          isFromLogin
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color_3),
                    ),
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (context) => ChangePasswordDialogScreen(),
                      ),
                    },
                    child: const Icon(Icons.settings),
                  ),
                )
        ]),
        isFromLogin
            ? PasswordFormField(
                label: 'Répétez le mot de passe',
                onChanged: (value) => model.secondPassword = value!,
              )
            : const SizedBox.shrink(),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color_3),
          ),
          onPressed: () async {
            if (controlForms(context, user)) {
              if (!isFromLogin && model.firstPassword == '') {
                EasyLoading.showError(
                    'Le mot de passe est obligatoire pour modifier votre compte');
              } else if (isFromLogin &&
                  (model.firstPassword == '' || model.secondPassword == '')) {
                EasyLoading.showError(
                    'Le mot de passe est obligatoire pour créer votre compte');
              } else if (isFromLogin &&
                  model.firstPassword != model.secondPassword) {
                EasyLoading.showError(
                    'Les deux mots de passe doivent être identiques');
              } else {
                await model.validate(
                    context, user, model.firstPassword, isFromLogin);
              }
            }
          },
          child: Text(isFromLogin ? 'Créer un compte' : 'Modifier le compte'),
        )
      ],
    ),
  );
}

bool controlForms(BuildContext context, UserModel userModel) {
  List<Widget> emptyFieldMessages = [];

  if (userModel.lastName == null || userModel.lastName == '') {
    emptyFieldMessages.add(const Text('- Nom de famille'));
  }
  if (userModel.firstName == null || userModel.firstName == '') {
    emptyFieldMessages.add(const Text('- Prénom'));
  }
  if (userModel.pseudo == null || userModel.pseudo == '') {
    emptyFieldMessages.add(const Text('- Pseudo'));
  }
  if (userModel.email == null || userModel.email == '') {
    emptyFieldMessages.add(const Text('- Email'));
  }

  if (emptyFieldMessages.isNotEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: const Text("Erreur de formulaire"),
          content: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Les champs suivants sont manquants : '),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: emptyFieldMessages,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Fermer"),
            )
          ],
        );
      },
    );

    return false;
  }
  return true;
}
