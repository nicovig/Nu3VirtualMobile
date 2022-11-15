import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import 'package:nu3virtual/ui/main_screen/main_screen_viewmodel.dart';

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
      const Icon(Icons.sports_football_outlined),
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
                          builder: (context) => SimpleDialog(
                            contentPadding: const EdgeInsets.all(20),
                            title: const Text('Déconnexion'),
                            children: [
                              const Text(
                                  "Êtes vous sûr de vouloir vous déconnecter ?"),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Spacer(),
                                  ElevatedButton(
                                      onPressed: (() =>
                                          model.disconnect(context)),
                                      child: const Text('Oui')),
                                  const Spacer(),
                                  ElevatedButton(
                                      onPressed: (() =>
                                          Navigator.pop(context, true)),
                                      child: const Text('Non')),
                                  const Spacer()
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.exit_to_app_sharp,
                        size: 26.0,
                      ),
                    ))
              ]),
          body: Column(children: [
            Text(
              _getDateHeaderBanner(date),
              style: TextStyle(color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
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

String _getDateHeaderBanner(DateTime date, context) {
  return 'Semaine ${_getWeekNumber(date)} - ${DateFormat('EEEE d MMMM yyyy').format(date)}';
}

num _getWeekNumber(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1, 0, 0);
  final firstMonday = startOfYear.weekday;
  final daysInFirstWeek = 8 - firstMonday;
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
// It might differ how you want to treat the first week
  if (daysInFirstWeek > 3) {
    weeks += 1;
  }
  return weeks;
}
