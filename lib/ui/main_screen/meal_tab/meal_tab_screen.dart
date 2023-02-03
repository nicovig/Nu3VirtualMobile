// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/dialogs/favorites_meals_dialog.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/layouts/screen_layouts/monitoring_box.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_viewmodel.dart';

// ignore: must_be_immutable
class MealTabScreen extends StatefulWidget {
  MealTabScreen(
      {super.key, required this.date, required this.handleOnPressedDateButton});

  @override
  _MealTabScreenState createState() => _MealTabScreenState();

  DateTime date;
  final Function(ChangeDateButtonTypeEnum type) handleOnPressedDateButton;
}

class _MealTabScreenState extends State<MealTabScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MealTabViewModel>.reactive(
      viewModelBuilder: () => MealTabViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.initData(widget.date);
        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          ),
          ChangeDateButtons(
            handleOnPressedLeftButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime(
                    widget.date.year, widget.date.month, widget.date.day - 1);
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.left);
              EasyLoading.dismiss(animation: false);
            }),
            handleOnPressedMiddleButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime.now();
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.middle);
              EasyLoading.dismiss(animation: false);
            }),
            handleOnPressedRightButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime(
                    widget.date.year, widget.date.month, widget.date.day + 1);
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.right);
              EasyLoading.dismiss(animation: false);
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: MonitoringBox(
                date: widget.date, monitoring: model.monitoringDisplayed),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade100),
                ),
                onPressed: () => model.openMealScreen(context, 0),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade100),
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FavoritesMealsDialog(
                          userId: model.userId ?? 0,
                          date: widget.date,
                          handleValidation: (mealUpdated, dialogContext) async {
                            await model.updateMeal(mealUpdated, dialogContext);
                            await model.loadData(widget.date);
                          });
                    }),
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
            physics: ScrollPhysics(),
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
                                        await model.loadData(widget.date);
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
