import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_time.dart';

class MealDialog extends StatefulWidget {
  final Function(MealModel, BuildContext) handleValidation;
  MealModel? mealToUpdate = MealModel();

  MealDialog({Key? key, required this.handleValidation, this.mealToUpdate})
      : super(key: key);

  @override
  _MealDialogState createState() => _MealDialogState();
}

class _MealDialogState extends State<MealDialog> {
  String name = '';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  int carbohydrate = 0;
  int lipid = 0;
  int protein = 0;
  int calorie = 0;

  String timeLabel = 'Heure du repas';

  @override
  initState() {
    final mealToUpdate = widget.mealToUpdate;
    if (mealToUpdate != null) {
      name = mealToUpdate.name ?? '';
      date = mealToUpdate.date ?? DateTime.now();
      time = mealToUpdate.date != null
          ? TimeOfDay(hour: date.hour, minute: date.minute)
          : TimeOfDay.now();
      carbohydrate = mealToUpdate.carbohydrate ?? 0;
      lipid = mealToUpdate.lipid ?? 0;
      protein = mealToUpdate.protein ?? 0;
      calorie = mealToUpdate.calorie ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text(
          "Créer un repas",
          textAlign: TextAlign.center,
        ),
        children: [
          CustomFormField(
              onChanged: (value) {
                if (value != null) name = value;
              },
              initialValue: name != '' ? name : '',
              hintText: 'Nom'),
          CustomFormFieldDate(
              initialValue: date,
              firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1,
                  DateTime.now().day),
              label: 'Date du repas',
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
                  DateTime.now().day),
              handleOnSaved: (value) {
                if (value != null) date = value;
              }),
          CustomFormFieldTime(
              initialValue: '${time.hour}h ${time.minute}min',
              label: timeLabel,
              labelColor: timeLabel == '${time.hour}h ${time.minute}min'
                  ? Colors.black
                  : Colors.grey.shade600,
              handleOnChanged: (value) {
                if (value != null) {
                  time = value;
                  timeLabel = '${time.hour}h ${time.minute}min';
                  setState(() {});
                }
              }),
          CustomFormField(
            hintText: 'Glucides',
            initialValue:
                carbohydrate.toString() != '0' ? carbohydrate.toString() : '',
            onChanged: (value) {
              if (value != null) carbohydrate = int.parse(value);
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
              if (value != null) lipid = int.parse(value);
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
            initialValue: protein.toString() != '0' ? protein.toString() : '',
            onChanged: (value) {
              if (value != null) protein = int.parse(value);
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
            initialValue: calorie.toString() != '0' ? calorie.toString() : '',
            onChanged: (value) {
              if (value != null) calorie = int.parse(value);
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
                  date = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  MealModel meal = MealModel(
                    id: widget.mealToUpdate?.id,
                    name: name,
                    date: date,
                    carbohydrate: carbohydrate,
                    lipid: lipid,
                    protein: protein,
                    calorie: calorie,
                  );
                  widget.handleValidation(meal, context);
                },
                child: const Text("Ajouter")),
          ),
        ]);
  }
}
