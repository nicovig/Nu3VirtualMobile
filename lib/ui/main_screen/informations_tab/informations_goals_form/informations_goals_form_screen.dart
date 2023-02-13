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
            child: Column(
              children: [
                const CustomTitle(title: "Réglages de mes objectifs"),
                snapshot.hasData
                    ? getNutritionGoalsGridView(
                        model, context, snapshot.data ?? [])
                    : const LoadingBox(),
                snapshot.hasData
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade300),
                        ),
                        onPressed: () async {
                          await model.updateNutritionGoals(context);
                        },
                        child: const Text("Modifier"),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getNutritionGoalsGridView(InformationsGoalsFormViewModel model,
    BuildContext context, List<NutritionGoalDisplayedModel> nutritionGoals) {
  const double spacingBetweenForms = 8;
  model.nutritionGoals = nutritionGoals;
  List<Widget> nutritionGoalsRowsFormFields = [];

  model.nutritionGoals.forEach((nutritionGoal) {
    nutritionGoalsRowsFormFields.add(
      Center(
        child: Text(
          nutritionGoal.name ?? '',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
    nutritionGoalsRowsFormFields.add(
      Center(
        child: SizedBox(
          width: 75,
          child: CustomFormField(
            label: 'Objectif',
            initialValue: nutritionGoal.totalValue.toString() != '0'
                ? nutritionGoal.totalValue.toString()
                : '',
            onChanged: (value) {
              if (value != null && value != "") {
                nutritionGoal.totalValue = int.parse(value);
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9\.-]"),
              )
            ],
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
    nutritionGoalsRowsFormFields.add(
      Center(
        child: SizedBox(
          width: 75,
          child: CustomFormField(
            label: 'Ordre',
            initialValue: nutritionGoal.order.toString() != '0'
                ? nutritionGoal.order.toString()
                : '',
            onChanged: (value) {
              if (value != null && value != "") {
                nutritionGoal.order = int.parse(value);
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9\.-]"),
              )
            ],
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
  });

  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height - 275,
    child: GridView.count(
      physics: ScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      children: nutritionGoalsRowsFormFields,
    ),
  );
}
