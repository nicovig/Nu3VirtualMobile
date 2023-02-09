import 'package:flutter/widgets.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class InformationsTabViewModel extends ChangeNotifier {
  final NutritionGoalService _nutritionGoalService =
      getIt<NutritionGoalService>();

  final UserStore _userStore = getIt<UserStore>();

  List<NutritionGoalDisplayedModel> informationGoals = [];
  UserModel user = UserModel();

  Future initData(DateTime date) async {
    user = await _userStore.getCurrentUser();
    loadData(date);
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    await _getNutritionGoals(date);
    notifyListeners();
  }

  updateNutritionGoals(BuildContext context) {
    Navigator.pushNamed(context, nutritionGoalsRoute);
  }

  updateUserInformations(BuildContext context) {
    Navigator.pushNamed(context, modifyUserRoute, arguments: false);
  }

  Future _getNutritionGoals(date) async {
    informationGoals = await _nutritionGoalService
        .getAllNutritionGoalsByUserIdAndDate(user.id, date);
  }
}
