import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';

class WorkoutDialog extends StatefulWidget {
  WorkoutDialog(
      {Key? key, required this.handleValidation, this.workoutToUpdate})
      : super(key: key);

  @override
  _WorkoutDialogState createState() => _WorkoutDialogState();

  final Function(WorkoutModel, BuildContext) handleValidation;
  WorkoutModel? workoutToUpdate = WorkoutModel();
}

class _WorkoutDialogState extends State<WorkoutDialog> {
  String? name;
  DateTime date = DateTime.now();
  int? caloriesBurned;

  int minutes = 0;
  int seconds = 0;

  @override
  initState() {
    final workoutToUpdate = widget.workoutToUpdate;
    if (workoutToUpdate != null) {
      name = workoutToUpdate.name ?? '';
      date = workoutToUpdate.date ?? DateTime.now();
      minutes = Duration(seconds: workoutToUpdate.timeInSeconds ?? 0).inMinutes;
      seconds = workoutToUpdate.timeInSeconds ?? 0 % 60;
      caloriesBurned = workoutToUpdate.caloriesBurned ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text(
          "Créer une séance",
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
              label: 'Date de la séance',
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
                  DateTime.now().day),
              handleOnSaved: (value) {
                if (value != null) date = value;
              }),
          const SizedBox(
            width: 60,
            height: 60,
            child: Text('Durée'),
          ),
          Row(
            children: [
              CustomFormField(
                hintText: 'Minutes',
                initialValue:
                    minutes.toString() != '0' ? minutes.toString() : '',
                onChanged: (value) {
                  if (value != null) minutes = int.parse(value);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[0-9\.-]"),
                  )
                ],
                keyboardType: TextInputType.number,
              ),
              CustomFormField(
                hintText: 'Secondes',
                initialValue:
                    seconds.toString() != '0' ? seconds.toString() : '',
                onChanged: (value) {
                  if (value != null) seconds = int.parse(value);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[0-9\.-]"),
                  )
                ],
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          CustomFormField(
            hintText: 'Calories ',
            initialValue: caloriesBurned.toString() != '0'
                ? caloriesBurned.toString()
                : '',
            onChanged: (value) {
              if (value != null) caloriesBurned = int.parse(value);
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9\.-]"),
              )
            ],
            keyboardType: TextInputType.number,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
                onPressed: () {
                  date = DateTime(date.year, date.month, date.day);
                  WorkoutModel workout = WorkoutModel(
                    id: widget.workoutToUpdate?.id,
                    name: name,
                    date: date,
                    timeInSeconds: minutes * 60 + seconds,
                    caloriesBurned: caloriesBurned,
                  );
                  widget.handleValidation(workout, context);
                },
                child: const Text("Ajouter")),
          ),
        ]);
  }
}
