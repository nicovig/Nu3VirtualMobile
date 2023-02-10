import 'package:get_it/get_it.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service_api.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service_store.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/date/date_service_store.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service_api.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service_api.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service_api.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service_api.dart';
import 'package:nu3virtual/core/services/user/user_service_api.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/user/user_service_store.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/core/services/workout/workout_service_api.dart';

final getIt = GetIt.instance;

// Note that we are registering services as a lazy singleton.
// It only gets initialized when it’s first used.
// If you want it to be initialized on app startup, then use registerSingleton() instead.
// Since it’s a singleton, you’ll always have the same instance of your service.
setupServiceLocator() {
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceApi());
  getIt.registerLazySingleton<AuthenticationStore>(
      () => AuthenticationServiceStore());
  getIt.registerLazySingleton<FavoriteMealService>(
      () => FavoriteMealServiceApi());
  getIt.registerLazySingleton<DateStore>(() => DateServiceStore());
  getIt.registerLazySingleton<MealService>(() => MealServiceApi());
  getIt.registerLazySingleton<MonitoringService>(() => MonitoringServiceApi());
  getIt
      .registerLazySingleton<NutritionGoalService>(() => NutritionServiceApi());
  getIt.registerLazySingleton<UserService>(() => UserServiceApi());
  getIt.registerLazySingleton<UserStore>(() => UserServiceStore());
  getIt.registerLazySingleton<WorkoutService>(() => WorkoutServiceApi());
}
