// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:event/event.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
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
                  backgroundColor: MaterialStateProperty.all(color_3),
                ),
                onPressed: () => model.openMealScreen(context, 0),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      model.favoritesMeals.isNotEmpty
                          ? color_3
                          : Colors.grey.shade300),
                ),
                onPressed: () {
                  if (model.favoritesMeals.isNotEmpty) {
                    model.openFavoriteMealScreen(context);
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
                  'P: ${meal.protein}g G: ${meal.carbohydrate}g C: ${meal.calorie}g';
              return Card(
                child: Slidable(
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
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                          backgroundColor: color_red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Supprimer')
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (BuildContext context) =>
                              model.openMealScreen(context, meal.id ?? 0),
                          backgroundColor: color_2,
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Modifier')
                    ],
                  ),
                  child: ListTile(
                    title: Text(meal.name ?? ''),
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
