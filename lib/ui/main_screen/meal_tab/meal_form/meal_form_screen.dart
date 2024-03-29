// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:date_field/date_field.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_meal_type.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_form/meal_form_viewmodel.dart';

class MealFormScreen extends StatefulWidget {
  const MealFormScreen({super.key});

  @override
  _MealFormScreenState createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as int;

    return ViewModelBuilder<MealFormViewModel>.reactive(
      viewModelBuilder: () => MealFormViewModel(),
      builder: (context, model, child) => FutureBuilder<MealModel>(
        future: model.loadData(mealId),
        builder: (BuildContext context, AsyncSnapshot<MealModel> snapshot) =>
            Scaffold(
          appBar: CustomAppBar(
              title: snapshot.hasData
                  ? '${model.user.firstName} - ${model.user.weight}kg'
                  : '',
              displayDisconnectionButton: false),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: !snapshot.hasData
                    ? [const LoadingBox()]
                    : [
                        const CustomTitle(title: "Création d'un repas"),
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 50,
                                child: CustomFormField(
                                    onChanged: (value) {
                                      if (value != null && value != "") {
                                        snapshot.data?.name = value;
                                      }
                                    },
                                    initialValue: snapshot.data?.name,
                                    label: 'Nom')),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                              child: StarButton(
                                isStarred: snapshot.data?.isFavorite,
                                iconSize: 40,
                                valueChanged: (isStarred) {
                                  snapshot.data?.isFavorite = isStarred as bool;
                                  if (snapshot.data != null &&
                                      snapshot.data?.isFavorite != null &&
                                      snapshot.data?.isFavorite == true) {
                                    EasyLoading.showSuccess(
                                        'Le plat sera ajouté aux favoris');
                                  }
                                  if (snapshot.data != null &&
                                      snapshot.data?.isFavorite != null &&
                                      snapshot.data?.isFavorite == false) {
                                    EasyLoading.showSuccess(
                                        'Le plat sera enlevé des favoris');
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        CustomFormFieldMealType(
                            mealType: snapshot.data?.type ?? MealTypeEnum.snack,
                            handleOnPressedRadioButton: (MealTypeEnum value) =>
                                snapshot.data?.type = value),
                        CustomFormFieldDate(
                          initialValue: snapshot.data?.date ?? DateTime.now(),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          firstDate: DateTime(DateTime.now().year,
                              DateTime.now().month - 1, DateTime.now().day),
                          label: 'Date du repas',
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month + 1, DateTime.now().day),
                          handleOnSaved: (value) {
                            if (value != null) {
                              snapshot.data?.date = DateTime(
                                  value.year,
                                  value.month,
                                  value.day,
                                  value.hour,
                                  value.minute);
                            }
                          },
                        ),
                        CustomFormField(
                          label: 'Glucides (grammes)',
                          initialValue:
                              snapshot.data?.carbohydrate.toString() != '0'
                                  ? snapshot.data?.carbohydrate.toString()
                                  : '',
                          onChanged: (value) {
                            if (value != null && value != "") {
                              snapshot.data?.carbohydrate = int.parse(value);
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9\.-]"),
                            )
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        CustomFormField(
                          label: 'Lipides (grammes)',
                          initialValue: snapshot.data?.lipid.toString() != '0'
                              ? snapshot.data?.lipid.toString()
                              : '',
                          onChanged: (value) {
                            if (value != null && value != "") {
                              snapshot.data?.lipid = int.parse(value);
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9\.-]"),
                            )
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        CustomFormField(
                          label: 'Protéines (grammes)',
                          initialValue: snapshot.data?.protein.toString() != '0'
                              ? snapshot.data?.protein.toString()
                              : '',
                          onChanged: (value) {
                            if (value != null && value != "") {
                              snapshot.data?.protein = int.parse(value);
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9\.-]"),
                            )
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        CustomFormField(
                          label: 'Calories',
                          initialValue: snapshot.data?.calorie.toString() != '0'
                              ? snapshot.data?.calorie.toString()
                              : '',
                          onChanged: (value) {
                            if (value != null && value != "") {
                              snapshot.data?.calorie = int.parse(value);
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[0-9]"),
                            )
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        CustomFormField(
                            maxLines: 2,
                            onChanged: (value) {
                              if (value != null && value != "") {
                                snapshot.data?.notes = value;
                              }
                            },
                            initialValue: snapshot.data?.notes,
                            label: 'Notes'),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(color_3),
                            ),
                            onPressed: () async {
                              model.meal = MealModel(
                                  id: snapshot.data?.id,
                                  name: snapshot.data?.name,
                                  type: snapshot.data?.type,
                                  isFavorite: snapshot.data?.isFavorite,
                                  date: snapshot.data?.date,
                                  carbohydrate: snapshot.data?.carbohydrate,
                                  lipid: snapshot.data?.lipid,
                                  protein: snapshot.data?.protein,
                                  calorie: snapshot.data?.calorie,
                                  notes: snapshot.data?.notes);
                              if (controlForms(model.meal)) {
                                await model.handleValidation(context);
                              }
                            },
                            child: Text(snapshot.data?.id == 0
                                ? "Ajouter"
                                : "Modifier"),
                          ),
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool controlForms(MealModel mealModel) {
  if (mealModel.name == null || mealModel.name == '') {
    EasyLoading.showError("Le nom est requis");
    return false;
  }
  return true;
}

getTimeInitialValue(int? snapshotDateHour, int? snapshotDateMinute) {
  return '${snapshotDateHour}h ${snapshotDateMinute}min';
}
