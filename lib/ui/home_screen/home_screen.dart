import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/meal_dialog/meal_dialog.dart';
import 'package:nu3virtual/ui/home_screen/home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  //constructor
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('Bonjour ${model.user.firstName}'),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => model.disconnect(context),
                      child: const Icon(
                        Icons.exit_to_app_sharp,
                        size: 26.0,
                      ),
                    ))
              ],
            ),
            body: SingleChildScrollView(
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
            )));
  }
}
