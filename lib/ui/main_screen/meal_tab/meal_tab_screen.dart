import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_viewmodel.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_dialog/meal_dialog.dart';

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
      onModelReady: (model) {
        model.loadData(date);
      },
      builder: (context, model, child) => Column(
        children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: model.mealsDisplayed.length,
              itemBuilder: (context, index) {
                final meal = model.mealsDisplayed[index];
                var subtitle =
                    'P: ${meal.protein} G: ${meal.carbohydrate} C: ${meal.calorie}';
                return Slidable(
                    key: Key('meal-index-$index'),
                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Supprimer"),
                                    content: Text(
                                        'Êtes vous sûr de vouloir supprimer le repas "${meal.name}"'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () async {
                                            await model.deleteMeal(
                                                meal.id ?? 0, context);
                                            await model.getMeals(date);
                                          },
                                          child: const Text("Oui")),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Non"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Supprimer',
                        )
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MealDialog(
                                      mealToUpdate: meal,
                                      handleValidation:
                                          (mealUpdated, dialogContext) async {
                                        await model.updateMeal(
                                            mealUpdated, dialogContext);
                                        await model.getMeals(date);
                                      });
                                });
                          },
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Modifier',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(meal.name ?? ''),
                      subtitle: Text(subtitle),
                    ));
              }),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade100)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      MealDialog(handleValidation: (meal, dialogContext) async {
                    meal.userId = model.userId;
                    await model.addMeal(meal, dialogContext);
                    await model.getMeals(date);
                    setState(() {});
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
