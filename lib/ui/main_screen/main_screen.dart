import 'package:flutter/material.dart';
import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_screen.dart';
import 'package:nu3virtual/ui/main_screen/workout_tab/workout_tab_screen.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/main_screen/main_screen_viewmodel.dart';

import 'disconnection_dialog/disconnection_dialog.dart';

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
        handleOnPressedDateButton: ((ChangeDateButtonTypeEnum type) async {
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
        }),
      ),
      WorkoutTabScreen(
        date: date,
        handleOnPressedDateButton: ((ChangeDateButtonTypeEnum type) async {
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
        }),
      ),
      const Icon(Icons.accessibility_new_outlined)
    ];

    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(),
      onModelReady: (model) => {
        model.loadData(),
        if (model.user.id != null)
          setState(() {
            if (model.user.id != null) {
              userId = model.user.id!;
            }
          })
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
                                    {model.disconnect(context)}));
                      },
                      child: const Icon(
                        Icons.exit_to_app_sharp,
                        size: 26.0,
                      ),
                    ))
              ]),
          body: Column(children: [
            Container(
              //height: MediaQuery.of(context).size.height, <-- avoid error with no height define (needed when try to put the "add" button on bottom list)
              child: pages.elementAt(selectedIndex),
            ),
          ]),
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
}
