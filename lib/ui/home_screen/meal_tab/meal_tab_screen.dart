import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/home_screen/meal_tab/meal_tab_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/home_screen/meal_tab/meal_dialog/meal_dialog.dart';

class MealTabScreen extends StatefulWidget {
  @override
  _MealTabScreenState createState() => _MealTabScreenState();
}

class _MealTabScreenState extends State<MealTabScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MealTabViewModel>.reactive(
      viewModelBuilder: () => MealTabViewModel(),
      onModelReady: (model) => model.loadData(date),
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: (() async {
                    setState(() {
                      date = DateTime(date.year, date.month, date.day - 1);
                    });
                    await model.getMeals(date);
                  }),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade50)))),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.blue)),
              ElevatedButton(
                  onPressed: (() async {
                    setState(() {
                      date = DateTime.now();
                    });
                    await model.getMeals(date);
                  }),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade50)))),
                  child: const Text(
                    "Aujourd'hui",
                    style: TextStyle(color: Colors.blue),
                  )),
              ElevatedButton(
                  onPressed: (() async {
                    setState(() {
                      date = DateTime(date.year, date.month, date.day + 1);
                    });
                    await model.getMeals(date);
                  }),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue.shade50)))),
                  child:
                      const Icon(Icons.arrow_forward_ios, color: Colors.blue)),
            ],
          ),
          Text(
            "Date : ${date.day} ${date.month} ${date.year}",
            style: const TextStyle(color: Colors.black),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: model.meals.length,
              itemBuilder: (context, index) {
                final meal = model.meals[index];
                var subtitle =
                    'P: ${meal.protein} G: ${meal.carbohydrate} C: ${meal.calorie}';
                return ListTile(
                  title: Text(
                      meal.name != null ? '${meal.name} ${meal.date}' : ''),
                  subtitle: Text(subtitle),
                );
              }),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade100)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MealDialog(
                      handleValidation: (meal, dialogContext) => {
                            meal.userId = model.userId,
                            model.addMeal(meal, dialogContext)
                          }),
                );
              },
              child: const Text("Ajouter un repas",
                  style: TextStyle(color: Colors.blue)))
        ],
      ),
    );
  }
}
