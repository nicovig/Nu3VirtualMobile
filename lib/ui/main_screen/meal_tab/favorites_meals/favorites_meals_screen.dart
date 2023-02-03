// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/main_screen/meal_tab/favorites_meals/favorites_meals_viewmodel.dart';

// ignore: must_be_immutable
class FavoritesMealsScreen extends StatefulWidget {
  FavoritesMealsScreen({super.key});

  @override
  _FavoritesMealsScreenState createState() => _FavoritesMealsScreenState();
}

class _FavoritesMealsScreenState extends State<FavoritesMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final timestampDate = ModalRoute.of(context)!.settings.arguments as int;

    return ViewModelBuilder<FavoritesMealsViewModel>.reactive(
      viewModelBuilder: () => FavoritesMealsViewModel(),
      onViewModelReady: (model) {
        model.loadData();
      },
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${model.user.firstName} - ${model.user.weight}kg'),
          ),
          body: const Text("Toto")),
    );
  }
}
