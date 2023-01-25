// ignore_for_file: library_private_types_in_public_api

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_meal_type.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_time.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/workout_tab/workout_form_screen/workout_form_viewmodel.dart';

// ignore: must_be_immutable
class WorkoutFormScreen extends StatefulWidget {
  WorkoutFormScreen({super.key});

  @override
  _WorkoutFormScreenState createState() => _WorkoutFormScreenState();
}

class _WorkoutFormScreenState extends State<WorkoutFormScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final workoutId = ModalRoute.of(context)!.settings.arguments as int;

    return ViewModelBuilder<WorkoutFormViewModel>.reactive(
      viewModelBuilder: () => WorkoutFormViewModel(),
      builder: (context, model, child) => FutureBuilder<WorkoutModel>(
          future: model.loadData(workoutId),
          builder: (BuildContext context,
                  AsyncSnapshot<WorkoutModel> snapshot) =>
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
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              model.workout = WorkoutModel(
                                                  id: model.workout.id,
                                                  name: snapshot.data?.name,
                                                  date: snapshot.data?.date,
                                                  timeInSeconds: snapshot
                                                      .data?.timeInSeconds,
                                                  caloriesBurned: snapshot
                                                      .data?.caloriesBurned,
                                                  userId:
                                                      snapshot.data?.userId);
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
