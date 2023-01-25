// ignore_for_file: library_private_types_in_public_api

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_meal_type.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_time.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_creation/meal_creation_viewmodel.dart';

// ignore: must_be_immutable
class MealCreationScreen extends StatefulWidget {
  MealCreationScreen({super.key});

  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String timeLabel = 'Heure du repas';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as int;

    return ViewModelBuilder<MealCreationViewModel>.reactive(
      viewModelBuilder: () => MealCreationViewModel(),
      builder: (context, model, child) => FutureBuilder<MealModel>(
          future: model.loadData(mealId),
          builder: (BuildContext context, AsyncSnapshot<MealModel> snapshot) =>
              Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: snapshot.hasData
                        ? Text(
                            '${model.user.firstName} - ${model.user.weight}kg')
                        : null,
                  ),
                  body: SingleChildScrollView(
                      child: SafeArea(
                          child: Column(
                              children: !snapshot.hasData
                                  ? [const LoadingBox()]
                                  : [
                                      Row(children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                50,
                                            child: CustomFormField(
                                                onChanged: (value) {
                                                  if (value != null &&
                                                      value != "") {
                                                    snapshot.data?.name = value;
                                                  }
                                                },
                                                initialValue:
                                                    snapshot.data?.name,
                                                hintText: 'Nom')),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 12, 0, 0),
                                            child: StarButton(
                                                isStarred:
                                                    snapshot.data?.isFavorite,
                                                iconSize: 40,
                                                valueChanged: (isStarred) {
                                                  snapshot.data?.isFavorite =
                                                      isStarred as bool;
                                                  if (snapshot.data != null &&
                                                      snapshot.data
                                                              ?.isFavorite !=
                                                          null &&
                                                      snapshot.data
                                                              ?.isFavorite ==
                                                          true) {
                                                    EasyLoading.showSuccess(
                                                        'Le plat sera ajouté aux favoris');
                                                  }
                                                }))
                                      ]),
                                      CustomFormFieldMealType(
                                          handleOnPressedRadioButton:
                                              (MealTypeEnum value) =>
                                                  snapshot.data?.type = value),
                                      CustomFormFieldDate(
                                          initialValue: date,
                                          firstDate: DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month - 1,
                                              DateTime.now().day),
                                          label: 'Date du repas',
                                          lastDate: DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month + 1,
                                              DateTime.now().day),
                                          handleOnSaved: (value) {
                                            if (value != null && value != "")
                                              date = value;
                                          }),
                                      CustomFormFieldTime(
                                          //initialValue: '${time.hour}h ${time.minute}min',
                                          label: timeLabel,
                                          labelColor: timeLabel ==
                                                  '${time.hour}h ${time.minute}min'
                                              ? Colors.black
                                              : Colors.grey.shade600,
                                          handleOnChanged: (value) async {
                                            if (value != null && value != "") {
                                              time = value;
                                              timeLabel =
                                                  '${time.hour}h ${time.minute}min';
                                              setState(() {});
                                            }
                                          }),
                                      CustomFormField(
                                        hintText: 'Glucides',
                                        initialValue: snapshot
                                                    .data?.carbohydrate
                                                    .toString() !=
                                                '0'
                                            ? snapshot.data?.carbohydrate
                                                .toString()
                                            : '',
                                        onChanged: (value) {
                                          if (value != null && value != "") {
                                            snapshot.data?.carbohydrate =
                                                int.parse(value);
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
                                        hintText: 'Lipides',
                                        initialValue: snapshot.data?.lipid
                                                    .toString() !=
                                                '0'
                                            ? snapshot.data?.lipid.toString()
                                            : '',
                                        onChanged: (value) {
                                          if (value != null && value != "") {
                                            snapshot.data?.lipid =
                                                int.parse(value);
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
                                        hintText: 'Protéines',
                                        initialValue: snapshot.data?.protein
                                                    .toString() !=
                                                '0'
                                            ? snapshot.data?.protein.toString()
                                            : '',
                                        onChanged: (value) {
                                          if (value != null && value != "") {
                                            snapshot.data?.protein =
                                                int.parse(value);
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
                                        hintText: 'Calories',
                                        initialValue: snapshot.data?.calorie
                                                    .toString() !=
                                                '0'
                                            ? snapshot.data?.calorie.toString()
                                            : '',
                                        onChanged: (value) {
                                          if (value != null && value != "") {
                                            snapshot.data?.calorie =
                                                int.parse(value);
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
                                          hintText: 'Notes'),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              date = DateTime(
                                                  date.year,
                                                  date.month,
                                                  date.day,
                                                  time.hour,
                                                  time.minute);
                                              model.meal = MealModel(
                                                  id: model.meal.id,
                                                  name: snapshot.data?.name,
                                                  type: snapshot.data?.type,
                                                  isFavorite:
                                                      snapshot.data?.isFavorite,
                                                  date: date,
                                                  carbohydrate: snapshot
                                                      .data?.carbohydrate,
                                                  lipid: snapshot.data?.lipid,
                                                  protein:
                                                      snapshot.data?.protein,
                                                  calorie:
                                                      snapshot.data?.calorie,
                                                  notes: snapshot.data?.notes);
                                              await model
                                                  .handleValidation(context);
                                            },
                                            child: Text(snapshot.data?.id == 0
                                                ? "Ajouter"
                                                : "Modifier")),
                                      )
                                    ]))))),
    );
  }
}
