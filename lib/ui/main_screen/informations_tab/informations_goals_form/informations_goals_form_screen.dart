// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/services/nutrition_goal/models/update_nutrition_goals_request.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_goals_form/informations_goals_form_viewmodel.dart';

// ignore: must_be_immutable
class InformationsGoalsFormScreen extends StatefulWidget {
  InformationsGoalsFormScreen({super.key});

  @override
  _InformationsGoalsFormScreenState createState() =>
      _InformationsGoalsFormScreenState();
}

class _InformationsGoalsFormScreenState
    extends State<InformationsGoalsFormScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InformationsGoalsFormViewModel>.reactive(
      viewModelBuilder: () => InformationsGoalsFormViewModel(),
      builder: (context, model, child) =>
          FutureBuilder<List<NutritionGoalDisplayedModel>>(
        future: model.loadData(),
        builder: (BuildContext context,
                AsyncSnapshot<List<NutritionGoalDisplayedModel>> snapshot) =>
            Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: snapshot.hasData
                ? Text('${model.user.firstName} - ${model.user.weight}kg')
                : null,
          ),
          body: SingleChildScrollView(
            child: snapshot.hasData
                ? Column(
                    children: [
                      const CustomTitle(title: "Réglages de mes objectifs"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 400,
                        child: ReorderableListView(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          children: getNutritionGoalsTiles(
                              model, context, snapshot.data ?? []),
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final NutritionGoalDisplayedModel item =
                                  model.nutritionGoals.removeAt(oldIndex);
                              model.nutritionGoals.insert(newIndex, item);
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade300),
                        ),
                        onPressed: () async {
                          await model.updateNutritionGoals(context);
                        },
                        child: const Text("Modifier"),
                      )
                    ],
                  )
                : const LoadingBox(),
          ),
        ),
      ),
    );
  }
}

List<Widget> getNutritionGoalsTiles(InformationsGoalsFormViewModel model,
    BuildContext context, List<NutritionGoalDisplayedModel> nutritionGoals) {
  model.nutritionGoals = nutritionGoals;
  List<Widget> nutritionGoalsListTile = [];

  for (int index = 0; index < model.nutritionGoals.length; index += 1) {
    var nutritionGoal = model.nutritionGoals[index];

    nutritionGoalsListTile.add(
      Padding(
        key: Key('$index'),
        padding: const EdgeInsets.only(top: 20),
        child: ListTile(
          key: Key('$index'),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue.shade200, width: 1),
            borderRadius: BorderRadius.circular(1),
          ),
          contentPadding: const EdgeInsets.all(0),
          minVerticalPadding: 0,
          title: Row(
            children: [
              SizedBox(
                width: 30,
                height: 56,
                child: Container(
                  color: Colors.blue.shade200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 18, 0, 0),
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: SizedBox(
                  width: 85,
                  child: Text(
                    nutritionGoal.name ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: 75,
                  child: Text(
                    'Objectif : ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: 30,
                  child: TextFormField(
                    initialValue: nutritionGoal.totalValue.toString() != '0'
                        ? nutritionGoal.totalValue.toString()
                        : '',
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return nutritionGoalsListTile;
}
