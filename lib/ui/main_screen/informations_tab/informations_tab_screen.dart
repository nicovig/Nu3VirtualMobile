// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:event/event.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_tab_viewmodel.dart';

// ignore: must_be_immutable
class InformationsTabScreen extends StatefulWidget {
  InformationsTabScreen({super.key, required this.dateChangeEvent});

  @override
  _InformationsTabScreenState createState() => _InformationsTabScreenState();

  Event<EventArgs> dateChangeEvent;
}

class _InformationsTabScreenState extends State<InformationsTabScreen> {
  @override
  void deactivate() {
    widget.dateChangeEvent.unsubscribeAll();
    super.deactivate();
  }

  static const double spaceBetweenLinesPersonnalInformations = 6;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InformationsTabViewModel>.reactive(
      viewModelBuilder: () => InformationsTabViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.initData(widget.dateChangeEvent);
      },
      builder: (context, model, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                    style: const TextStyle(fontSize: 20, color: color_4),
                    DateFormat('EEEE d MMMM yyyy')
                        .format(model.currentDate)
                        .toString()),
                const Divider(height: 20, thickness: 0.8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getDataGoalsWidgetList(model),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    model.updateNutritionGoals(context);
                  }),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color_3)),
                  child: const Text('Modifier mes objetctifs'),
                ),
                const Divider(height: 20, thickness: 0.8),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Mes informations',
                          style: TextStyle(fontSize: 20, color: color_4),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Pseudo :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Prénom :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Nom :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Genre :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Date de naissance :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Taille :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Poids :'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text('Taille :'),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text(model.user.pseudo ?? ''),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text(model.user.firstName ?? ''),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text(model.user.lastName ?? ''),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text(
                                  getGenderEnumText(model.user.gender ?? 0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child: Text(getUserBirthday(model.user.birthday)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child:
                                  Text(getUserHeight(model.user.height ?? 0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom:
                                      spaceBetweenLinesPersonnalInformations),
                              child:
                                  Text(getUserWeight(model.user.weight ?? 0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(model.user.email ?? ''),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        model.updateUserInformations(context);
                      }),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(color_3)),
                      child: const Text('Modifier mes informations'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getDataGoalsWidgetList(InformationsTabViewModel model) {
  List<Widget> list = [];
  EasyLoading.show();
  for (var i = 0; i < model.informationGoals.length; i++) {
    var informationGoal = model.informationGoals[i];
    list.add(
      Column(
        children: [
          Text(informationGoal.name ?? ''),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Text(
                style: TextStyle(
                    fontSize: 22,
                    color: getMacronutrimentGoalPercentageColor(
                        informationGoal.achievedRatio)),
                getMacronutrimentGoalPercentage(informationGoal.achievedRatio)),
          ),
          CircularProgressIndicator(
            strokeWidth: 6,
            value: double.parse(
              (informationGoal.achievedRatio ?? 0).toString(),
            ),
            backgroundColor: Colors.red,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          const SizedBox(height: 20),
          Text(
              '${informationGoal.achievedValue}/${informationGoal.totalValue}'),
        ],
      ),
    );
  }
  EasyLoading.dismiss(animation: false);
  return list;
}

String getMacronutrimentGoalPercentage(num? achievedRatio) {
  if (achievedRatio != null) {
    var percentage = achievedRatio * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }
  return '';
}

Color getMacronutrimentGoalPercentageColor(num? achievedRatio) {
  if (achievedRatio != null) {
    if (achievedRatio < 0.33) {
      return color_red;
    }
    if (achievedRatio >= 0.33 && achievedRatio < 0.66) {
      return color_1;
    }
    if (achievedRatio >= 0.66 && achievedRatio <= 1) {
      return color_2;
    }
    if (achievedRatio > 1) {
      return color_5;
    }
  }
  return Colors.black;
}

String getUserBirthday(DateTime? birthday) {
  if (birthday != null) {
    return '${birthday.day}/${birthday.month}/${birthday.year}';
  }
  return '';
}

String getUserHeight(int heightUser) {
  return '$heightUser cm';
}

String getUserWeight(num weightUser) {
  return '$weightUser kg';
}
