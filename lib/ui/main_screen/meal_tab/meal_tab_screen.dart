// ignore_for_file: library_private_types_in_public_api

import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/main_screen/meal_tab/dialogs/favorite_meal_dialog.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_viewmodel.dart';

// ignore: must_be_immutable
class MealTabScreen extends StatefulWidget {
  MealTabScreen({super.key, required this.dateChangeEvent});

  @override
  _MealTabScreenState createState() => _MealTabScreenState();

  Event<EventArgs> dateChangeEvent;
}

class _MealTabScreenState extends State<MealTabScreen> {
  @override
  void deactivate() {
    widget.dateChangeEvent.unsubscribeAll();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MealTabViewModel>.reactive(
      viewModelBuilder: () => MealTabViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.initData(widget.dateChangeEvent);
        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade200),
                ),
                onPressed: () => model.openMealScreen(context, 0),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      model.favoritesMeals.length > 0
                          ? Colors.blue.shade200
                          : Colors.grey.shade300),
                ),
                onPressed: () {
                  if (model.favoritesMeals.length > 0) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FavoriteMealDialog(
                              favoritesMeals: model.favoritesMeals,
                              addFavoriteMealToDailyMeals:
                                  (favoriteMealId, dialogContext) async {
                                EasyLoading.show();
                                await model.addFavoriteMealToDailyMeals(
                                    dialogContext, favoriteMealId);
                                await model.loadData();
                                EasyLoading.dismiss(animation: false);
                              },
                              deleteFavoriteMeal: (favoriteMealId) async {
                                EasyLoading.show();
                                await model.deleteFavoriteMeal(favoriteMealId);
                                await model.loadData();
                                setState(() {});
                                EasyLoading.dismiss(animation: false);
                              });
                        });
                  } else {
                    EasyLoading.showInfo('Aucun favoris');
                  }
                },
                child: const Icon(Icons.star),
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
            itemCount: model.meals.length,
            itemBuilder: (context, index) {
              final meal = model.meals[index];
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
                                        EasyLoading.show();
                                        await model.deleteMeal(
                                            meal.id ?? 0, context);
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
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Supprimer')
                    ]),
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                      onPressed: (BuildContext context) =>
                          model.openMealScreen(context, meal.id ?? 0),
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.update,
                      label: 'Modifier')
                ]),
                child: ListTile(
                  title: Text(meal.name ?? ''),
                  subtitle: Text(subtitle),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
