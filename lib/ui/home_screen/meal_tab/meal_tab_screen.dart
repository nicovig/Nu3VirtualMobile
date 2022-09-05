import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/home_screen/meal_tab/meal_tab_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/home_screen/meal_tab/meal_dialog/meal_dialog.dart';

class MealTabScreen extends StatelessWidget {
  //constructor
  MealTabScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MealTabViewModel>.reactive(
        viewModelBuilder: () => MealTabViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade100),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.blue.shade50)))),
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.blue)),
                      ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade100),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.blue.shade50)))),
                          child: const Text(
                            "Aujourd'hui",
                            style: TextStyle(color: Colors.blue),
                          )),
                      ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade100),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.blue.shade50)))),
                          child: const Icon(Icons.arrow_forward_ios,
                              color: Colors.blue)),
                    ],
                  ),
                  const Text(
                    "Date choisie",
                    style: TextStyle(color: Colors.blue),
                  ),
                  const Text(
                    "Liste ici",
                    style: TextStyle(color: Colors.blue),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade100)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => MealDialog(
                              handleValidation: (meal, dialogContext) => {
                                    meal.id = userId,
                                    model.addMeal(meal, dialogContext)
                                  }),
                        );
                      },
                      child: const Text("Ajouter un repas",
                          style: TextStyle(color: Colors.blue)))
                ],
              ),
            ));
  }
}
