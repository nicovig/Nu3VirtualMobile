import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nu3virtual/layouts/screen_layouts/monitoring_box.dart';
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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.loadData();
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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                ),
                ChangeDateButtons(
                  handleOnPressedLeftButton: (() async {
                    EasyLoading.show();
                    setState(() {
                      model.updateDate(ChangeDateButtonTypeEnum.left);
                    });
                    EasyLoading.dismiss(animation: false);
                  }),
                  handleOnPressedMiddleButton: (() async {
                    EasyLoading.show();
                    setState(() {
                      model.updateDate(ChangeDateButtonTypeEnum.middle);
                    });
                    EasyLoading.dismiss(animation: false);
                  }),
                  handleOnPressedRightButton: (() async {
                    EasyLoading.show();
                    setState(() {
                      model.updateDate(ChangeDateButtonTypeEnum.right);
                    });
                    EasyLoading.dismiss(animation: false);
                  }),
                ),
                isMonitoringDisplayed(selectedIndex)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: MonitoringBox(
                            date: model.date,
                            monitoring: model.monitoringDisplayed),
                      )
                    : const SizedBox.shrink(),
                getTabDisplayed(model, selectedIndex)
              ],
            ),
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
}

Widget getTabDisplayed(MainScreenViewModel model, int selectedIndex) {
  final List<Widget> pages = <Widget>[
    MealTabScreen(dateChangeEvent: model.dateChangeEvent),
    WorkoutTabScreen(dateChangeEvent: model.dateChangeEvent),
    InformationsTabScreen(dateChangeEvent: model.dateChangeEvent)
  ];

  return pages.elementAt(selectedIndex);
}

bool isMonitoringDisplayed(int selectedIndex) {
  return selectedIndex < 2;
}

enum MainScreenTabEnum { meals, workouts, informations }
