// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_form/meal_form_viewmodel.dart';

// ignore: must_be_immutable
class MealFormScreen extends StatefulWidget {
  MealFormScreen({super.key});

  @override
  _MealFormScreenState createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as int;

    String timeValueDisplayed = '';

    return ViewModelBuilder<MealFormViewModel>.reactive(
      viewModelBuilder: () => MealFormViewModel(),
      builder: (context, model, child) => FutureBuilder<MealModel>(
        future: model.loadData(mealId),
        builder: (BuildContext context, AsyncSnapshot<MealModel> snapshot) =>
            Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: snapshot.hasData
                ? Text('${model.user.firstName} - ${model.user.weight}kg')
                : null,
          ),
          body: const Text('Toto'),
        ),
      ),
    );
  }
}
