import 'dart:io';

import 'package:flutter/material.dart';

import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/authentication_screen/authentication_screen.dart';
import 'package:nu3virtual/ui/home_screen/home_screen.dart';

void main() {
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
        theme:
            ThemeData(appBarTheme: const AppBarTheme(color: Colors.lightBlue)),
        home: AuthenticationScreen(title: 'NuVirtual'),
        routes: {'/home': (context) => new HomeScreen()},
        color: Colors.white,
        debugShowCheckedModeBanner: false);
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
