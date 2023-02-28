import 'package:flutter/widgets.dart';

import 'package:event/event.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class InformationsTabViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final NutritionGoalService _nutritionGoalService =
      getIt<NutritionGoalService>();

  final UserStore _userStore = getIt<UserStore>();

  DateTime currentDate = DateTime.now();
  List<NutritionGoalDisplayedModel> informationGoals = [];
  UserModel user = UserModel();

  Future initData(Event<EventArgs> dateChangeEvent) async {
    _dateChangeSubscribe(dateChangeEvent);
    user = await _userStore.getCurrentUser();
    loadData();
    notifyListeners();
  }

  Future loadData() async {
    currentDate = await _dateStore.getDate();
    await _getNutritionGoals(currentDate);
    notifyListeners();
  }

  updateNutritionGoals(BuildContext context) {
    Navigator.pushNamed(context, nutritionGoalsRoute);
  }

  updateUserInformations(BuildContext context) {
    Navigator.pushNamed(context, modifyUserRoute, arguments: false);
  }

  void _dateChangeSubscribe(Event<EventArgs> dateChangeEvent) {
    dateChangeEvent.subscribe((args) async {
      await loadData();
    });
  }

  Future _getNutritionGoals(date) async {
    informationGoals = await _nutritionGoalService
        .getAllNutritionGoalsByUserIdAndDate(user.id, date);
  }
}
