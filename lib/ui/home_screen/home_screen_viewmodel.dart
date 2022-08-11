import 'package:flutter/foundation.dart';

class HomeScreenViewModel extends ChangeNotifier {
  int _someValue = 0;
  int get someValue => _someValue;
  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

  void doSomthg() {
    // do something...
    notifyListeners();
  }
}
