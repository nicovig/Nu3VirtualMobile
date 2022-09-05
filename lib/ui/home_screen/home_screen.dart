import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/home_screen/meal_tab/meal_tab_screen.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/home_screen/home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  //constructor
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onModelReady: (model) => model.loadData(),
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
              ],
              bottom: const TabBar(
                indicatorPadding: EdgeInsets.all(5),
                unselectedLabelColor: Colors.white30,
                tabs: [
                  Tab(icon: Icon(Icons.restaurant_menu_outlined)),
                  Tab(icon: Icon(Icons.fitness_center_outlined)),
                  Tab(icon: Icon(Icons.accessibility_new_outlined))
                ],
              )),
          body: TabBarView(
            children: [
              MealTabScreen(userId: model.user.id ?? 0),
              const Icon(Icons.sports_football_outlined),
              const Icon(Icons.accessibility_new_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
