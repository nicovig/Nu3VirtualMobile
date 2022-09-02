import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/home_screen/meal_tab/meal_tab_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/meal_dialog/meal_dialog.dart';

class MealTabScreen extends StatelessWidget {
  //constructor
  MealTabScreen();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MealTabViewModel>.reactive(
        viewModelBuilder: () => MealTabViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => MealDialog(
                                  handleValidation: (meal, dialogContext) =>
                                      model.addMeal(meal, dialogContext)),
                            );
                          },
                          child: const Text("Ajouter un repas"))
                    ],
                  ),
                ],
              ),
            ));
  }
}
