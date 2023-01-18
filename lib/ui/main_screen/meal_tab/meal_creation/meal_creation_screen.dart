// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_meal_type.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_time.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_creation/meal_creation_viewmodel.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class MealCreationScreen extends StatefulWidget {
  MealCreationScreen({super.key});

  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  String name = '';
  MealTypeEnum mealType = MealTypeEnum.snack;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  int carbohydrate = 0;
  int lipid = 0;
  int protein = 0;
  int calorie = 0;

  String timeLabel = 'Heure du repas';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as int;

    return ViewModelBuilder<MealCreationViewModel>.reactive(
        viewModelBuilder: () => MealCreationViewModel(),
        onModelReady: (model) {
          model.getMealById(mealId);
          EasyLoading.show();
          EasyLoading.dismiss(animation: false);
        },
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('${model.user.firstName} - ${model.user.weight}kg'),
              ),
              body: Column(children: [
                CustomFormField(
                    onChanged: (value) {
                      if (value != null && value != "") name = value;
                    },
                    initialValue: name != '' ? name : '',
                    hintText: 'Nom'),
                CustomFormFieldMealType(
                    handleOnPressedRadioButton: (MealTypeEnum value) =>
                        mealType = value),
                CustomFormFieldDate(
                    initialValue: date,
                    firstDate: DateTime(DateTime.now().year,
                        DateTime.now().month - 1, DateTime.now().day),
                    label: 'Date du repas',
                    lastDate: DateTime(DateTime.now().year,
                        DateTime.now().month + 1, DateTime.now().day),
                    handleOnSaved: (value) {
                      if (value != null && value != "") date = value;
                    }),
                CustomFormFieldTime(
                    initialValue: '${time.hour}h ${time.minute}min',
                    label: timeLabel,
                    labelColor: timeLabel == '${time.hour}h ${time.minute}min'
                        ? Colors.black
                        : Colors.grey.shade600,
                    handleOnChanged: (value) {
                      if (value != null && value != "") {
                        time = value;
                        timeLabel = '${time.hour}h ${time.minute}min';
                        setState(() {});
                      }
                    }),
                CustomFormField(
                  hintText: 'Glucides',
                  initialValue: carbohydrate.toString() != '0'
                      ? carbohydrate.toString()
                      : '',
                  onChanged: (value) {
                    if (value != null && value != "")
                      carbohydrate = int.parse(value);
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
                  initialValue: lipid.toString() != '0' ? lipid.toString() : '',
                  onChanged: (value) {
                    if (value != null && value != "") lipid = int.parse(value);
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
                  initialValue:
                      protein.toString() != '0' ? protein.toString() : '',
                  onChanged: (value) {
                    if (value != null && value != "")
                      protein = int.parse(value);
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
                  initialValue:
                      calorie.toString() != '0' ? calorie.toString() : '',
                  onChanged: (value) {
                    if (value != null && value != "")
                      calorie = int.parse(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    )
                  ],
                  keyboardType: TextInputType.number,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                      onPressed: () {
                        date = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                        MealModel meal = MealModel(
                          id: model.meal?.id,
                          name: name,
                          date: date,
                          carbohydrate: carbohydrate,
                          lipid: lipid,
                          protein: protein,
                          calorie: calorie,
                        );
                        model.handleValidation(meal);
                      },
                      child: const Text("Ajouter")),
                )
              ]),
            ));
  }
}
