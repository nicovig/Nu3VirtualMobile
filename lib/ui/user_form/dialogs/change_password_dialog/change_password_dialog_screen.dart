import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/ui/user_form/dialogs/change_password_dialog/change_password_dialog_screen_viewmodel.dart';

class ChangePasswordDialogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordDialogScreenViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordDialogScreenViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.loadData();
        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        title: const Text('Changement du mot de passe'),
        children: [
          CustomFormField(
              onChanged: (value) {
                if (value != null && value != "") {
                  model.oldPassword = value;
                }
              },
              label: 'Ancien mot de passe'),
          CustomFormField(
              onChanged: (value) {
                if (value != null && value != "") {
                  model.firstNewPassword = value;
                }
              },
              label: 'Nouveau mot de passe'),
          CustomFormField(
            onChanged: (value) {
              if (value != null && value != "") model.secondNewPassword = value;
            },
            label: 'Répétez le mot de passe',
          ),
          ElevatedButton(
            onPressed: () async {
              if (model.oldPassword == '') {
                EasyLoading.showError("L'ancien mot de passe est requis");
              } else if (model.firstNewPassword == '' ||
                  model.secondNewPassword == '') {
                EasyLoading.showError("Le nouveau mot de passe est requis");
              } else if (model.firstNewPassword != model.secondNewPassword) {
                EasyLoading.showError(
                    "Les nouveaux mots de passe sont différents");
              }
              var isOk = await model.changePassword(context);
              if (isOk) {
                EasyLoading.showSuccess("Mot de passe changé avec succès");
                model.closeDialog(context);
              } else {
                EasyLoading.showError(
                    "L'ancien mot de passe est différent de celui renseigné à la création de votre compte");
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color_3),
            ),
            child: const Text("Modifier"),
          ),
        ],
      ),
    );
  }
}
