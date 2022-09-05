import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/home_screen/meal_tab/meal_tab_screen.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/home_screen/home_screen_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  //constructor
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userId = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      MealTabScreen(),
      const Icon(Icons.sports_football_outlined),
      const Icon(Icons.accessibility_new_outlined)
    ];

    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
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
                      onTap: () => model.disconnect(context),
                      child: const Icon(
                        Icons.exit_to_app_sharp,
                        size: 26.0,
                      ),
                    ))
              ]),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                icon: Icon(Icons.sports_football_outlined),
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
