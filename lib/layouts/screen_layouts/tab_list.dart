import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/meal_tab_screen.dart';

class TabList extends StatefulWidget {
  int tabSelected;

  TabList({Key? key, required this.tabSelected}) : super(key: key);

  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  @override
  initState() {}

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      MealTabScreen(),
      const Icon(Icons.sports_football_outlined),
      const Icon(Icons.accessibility_new_outlined)
    ];

    return pages.elementAt(widget.tabSelected);
  }
}
