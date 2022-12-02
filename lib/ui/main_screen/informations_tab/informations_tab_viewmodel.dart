import 'package:flutter/widgets.dart';

class InformationsTabViewModel extends ChangeNotifier {
  Future initData() async {
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    notifyListeners();
  }
}
