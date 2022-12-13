import 'package:flutter/widgets.dart';

class InformationsTabViewModel extends ChangeNotifier {
  Map<String, double> dataGoals = {
    "Food Items": 18.47,
    "Clothes": 17.70,
    "Technology": 4.25,
    "Cosmetics": 3.51,
    "Other": 2.83,
  };

  Future initData() async {
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    notifyListeners();
  }
}
