import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_tab_screen.dart';
import 'package:nu3virtual/ui/main_screen/main_screen_viewmodel.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_screen.dart';
import 'package:nu3virtual/ui/main_screen/workout_tab/workout_tab_screen.dart';

import 'dialogs/disconnection_dialog/disconnection_dialog.dart';

class MainScreen extends StatefulWidget {
  //constructor
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int userId = 0;
  int selectedIndex = 0;

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      MealTabScreen(
        date: date,
        handleOnPressedDateButton: ((ChangeDateButtonTypeEnum type) async =>
            handleDateChange(type)),
      ),
      WorkoutTabScreen(
        date: date,
        handleOnPressedDateButton: ((ChangeDateButtonTypeEnum type) async =>
            handleDateChange(type)),
      ),
      InformationsTabScreen(
        date: date,
        handleOnPressedDateButton: ((ChangeDateButtonTypeEnum type) async =>
            handleDateChange(type)),
      )
    ];

    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(),
      onModelReady: (model) {
        EasyLoading.show();
        model.loadData();
        if (model.user.id != null) {
          setState(() {
            if (model.user.id != null) {
              userId = model.user.id!;
            }
          });
        }
        if (ModalRoute.of(context)!.settings.arguments == null) {
          selectedIndex = 0;
        } else {
          selectedIndex = ModalRoute.of(context)!.settings.arguments as int;
        }

        EasyLoading.dismiss(animation: false);
      },
      builder: (context, model, child) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text('${model.user.firstName} - ${model.user.weight}kg'),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DisconnectionDialog(
                            handleOnPressedDisconnectButton: () =>
                                {model.disconnect(context)},
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.exit_to_app_sharp,
                        size: 26.0,
                      ),
                    ))
              ]),
          body: SingleChildScrollView(
            child: pages.elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => {
              setState(() {
                selectedIndex = value;
              })
            },
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_outlined),
                label: 'Repas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Sport',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new_outlined),
                label: 'Infos',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleDateChange(ChangeDateButtonTypeEnum type) {
    setState(() {
      switch (type) {
        case ChangeDateButtonTypeEnum.left:
          date = DateTime(date.year, date.month, date.day - 1);
          break;
        case ChangeDateButtonTypeEnum.middle:
          date = DateTime.now();
          break;
        case ChangeDateButtonTypeEnum.right:
          date = DateTime(date.year, date.month, date.day + 1);
          break;
      }
    });
  }
}

enum MainScreenTabEnum { meals, workouts, informations }
