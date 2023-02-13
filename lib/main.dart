import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_screen.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_goals_form/informations_goals_form_screen.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_form/meal_form_screen.dart';
import 'package:nu3virtual/ui/main_screen/workout_tab/workout_form/workout_form_screen.dart';
import 'package:nu3virtual/ui/user_form/user_form_screen.dart';

import 'ui/main_screen/meal_tab/favorite_meal/favorite_meal_screen.dart';

void main() {
  configEasyLoading();
  setupServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NuVirtual',
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.blue.shade300)),
        home: AuthenticationScreen(title: 'NuVirtual'),
        routes: {
          favoriteMealsRoute: (context) => FavoriteMealScreen(),
          homeRoute: (context) => MainScreen(),
          mealRoute: (context) => MealFormScreen(),
          modifyUserRoute: (context) => UserScreen(),
          nutritionGoalsRoute: (context) => InformationsGoalsFormScreen(),
          workoutRoute: (context) => WorkoutFormScreen()
        },
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init());
  }
}

//https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..progressColor = Colors.white
    ..boxShadow = <BoxShadow>[] // removes black background
    ..loadingStyle = EasyLoadingStyle.light
    ..textColor = Colors.black
    ..indicatorColor = Colors.blue.shade200 // color of animated loader
    ..lineWidth = 20
    ..backgroundColor = Colors.transparent;
}
