import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/ui/home_screen/home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  //constructor
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
            ));
  }
}
