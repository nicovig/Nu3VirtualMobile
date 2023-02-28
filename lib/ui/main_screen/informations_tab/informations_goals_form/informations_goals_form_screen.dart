// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_goals_form/dialogs/informations_goals_dialog/informations_goals_dialog.dart';
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
    List<Widget> getNutritionGoalsTiles(
        InformationsGoalsFormViewModel model,
        BuildContext context,
        List<NutritionGoalDisplayedModel> nutritionGoals) {
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
                side: BorderSide(color: color_4, width: 1),
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
                      color: color_4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 18, 0, 0),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 125,
                          child: Row(
                            children: [
                              Text(
                                nutritionGoal.name ?? '',
                                style: const TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.info,
                                  color: color_2,
                                ),
                                onPressed: () => openInformationDialog(
                                    context, model, nutritionGoal.type),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 65,
                              child: Text(
                                'Objectif :',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: TextFormField(
                                initialValue:
                                    nutritionGoal.totalValue.toString() != '0'
                                        ? nutritionGoal.totalValue.toString()
                                        : '',
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  if (value != null && value != "") {
                                    nutritionGoal.totalValue = int.parse(value);
                                  }
                                },
                              ),
                            ),
                            Text(
                              nutritionGoal.type ==
                                      MacronutrientTypeEnum.calorie.index
                                  ? 'kcal'
                                  : 'g',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: nutritionGoal.type ==
                                      MacronutrientTypeEnum.calorie.index
                                  ? 0
                                  : 19),
                          child: IconButton(
                            icon: Icon(
                              nutritionGoal.isActive
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: nutritionGoal.isActive
                                  ? color_3
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () => {
                              nutritionGoal.isActive = !nutritionGoal.isActive,
                              model.updateNutritionGoals(null),
                              setState(() => {}),
                              EasyLoading.showSuccess("L'objectif sera caché")
                            },
                          ),
                        ),
                      ],
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

    return ViewModelBuilder<InformationsGoalsFormViewModel>.reactive(
      viewModelBuilder: () => InformationsGoalsFormViewModel(),
      builder: (context, model, child) =>
          FutureBuilder<List<NutritionGoalDisplayedModel>>(
        future: model.loadData(),
        builder: (BuildContext context,
                AsyncSnapshot<List<NutritionGoalDisplayedModel>> snapshot) =>
            Scaffold(
          appBar: CustomAppBar(
              title: snapshot.hasData
                  ? '${model.user.firstName} - ${model.user.weight}kg'
                  : '',
              displayDisconnectionButton: false),
          body: SingleChildScrollView(
            child: snapshot.hasData
                ? Column(
                    children: [
                      const CustomTitle(title: "Réglages de mes objectifs"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 470,
                        child: ReorderableListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: getNutritionGoalsTiles(
                              model, context, snapshot.data ?? []),
                          onReorder: (int oldIndex, int newIndex) async {
                            EasyLoading.show();
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final NutritionGoalDisplayedModel item =
                                model.nutritionGoals.removeAt(oldIndex);
                            model.nutritionGoals.insert(newIndex, item);
                            await model.updateNutritionGoals(null);
                            setState(() {});
                            EasyLoading.dismiss();
                            EasyLoading.showSuccess('Objectifs modifiés');
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(color_3),
                        ),
                        onPressed: () async {
                          await model.updateNutritionGoals(context);
                        },
                        child: const Text("Modifier"),
                      ),
                    ],
                  )
                : const LoadingBox(),
          ),
        ),
      ),
    );
  }
}

openInformationDialog(BuildContext context,
    InformationsGoalsFormViewModel model, int? macronutrientType) {
  if (macronutrientType != null) {
    showDialog(
      context: context,
      builder: (context) => InformationsGoalsDialog(
          genderType: GenderEnum.values[model.user.gender ?? 0],
          macronutrientType: MacronutrientTypeEnum.values[macronutrientType]),
    );
  }
}
