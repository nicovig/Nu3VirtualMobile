import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/information_goals_model.dart';

class InformationsTabViewModel extends ChangeNotifier {
  List<InformationGoalsModel> informationGoals = [
    InformationGoalsModel(
        id: 1, order: 1, name: 'Calories', date: DateTime.now(), value: 0.87),
    InformationGoalsModel(
        id: 2, order: 2, name: 'Glucides', date: DateTime.now(), value: 0.75),
    InformationGoalsModel(
        id: 3, order: 3, name: 'Lipides', date: DateTime.now(), value: 0.90),
    InformationGoalsModel(
        id: 4, order: 4, name: 'Protéines', date: DateTime.now(), value: 0.98),
  ];

  Future initData() async {
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    notifyListeners();
  }
}
