// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:event/event.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/helpers/helpers.dart';
import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/ui/main_screen/workout_tab/workout_tab_viewmodel.dart';

// ignore: must_be_immutable
class WorkoutTabScreen extends StatefulWidget {
  WorkoutTabScreen({super.key, required this.dateChangeEvent});

  @override
  _WorkoutTabScreenState createState() => _WorkoutTabScreenState();

  Event<EventArgs> dateChangeEvent;
}

class _WorkoutTabScreenState extends State<WorkoutTabScreen> {
  @override
  void deactivate() {
    widget.dateChangeEvent.unsubscribeAll();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutTabViewModel>.reactive(
      viewModelBuilder: () => WorkoutTabViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.initData(widget.dateChangeEvent);
        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color_3),
                ),
                onPressed: () => model.openWorkoutScreen(context, 0),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: model.workouts.length,
            itemBuilder: (context, index) {
              final workout = model.workouts[index];
              var subtitle = workout.notes ?? '';
              return Card(
                child: Slidable(
                  key: Key('workout-index-$index'),
                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (BuildContext context) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  title: const Text("Supprimer"),
                                  content: Text(
                                      'Êtes vous sûr de vouloir supprimer la séance "${workout.name}"'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () async {
                                        EasyLoading.show();
                                        await model.deleteWorkout(
                                            workout.id ?? 0, context);
                                        await model.loadData();
                                        EasyLoading.dismiss(animation: false);
                                      },
                                      child: const Text("Oui"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Non"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: color_red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Supprimer')
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (BuildContext context) =>
                              model.openWorkoutScreen(context, workout.id ?? 0),
                          backgroundColor: color_2,
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Modifier'),
                    ],
                  ),
                  child: ListTile(
                    title: getWorkoutTitle(workout),
                    subtitle: Text(subtitle),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget getWorkoutTitle(WorkoutModel workout) {
  String workoutName = workout.name ?? '';
  if (workout.timeInSeconds != 0) {
    int minutes = getMinutesWithTimeInSeconds(workout.timeInSeconds);
    int seconds = getSecondsRemains(workout.timeInSeconds);
    return Text('$workoutName - $minutes min $seconds sec');
  } else {
    return Text(workoutName);
  }
}
