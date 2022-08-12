import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/layouts/forms/custom_form_field.dart';
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
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                        title: const Text(
                                          "Créer un repas",
                                          textAlign: TextAlign.center,
                                        ),
                                        children: [
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Nom'),
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Date'),
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Glucides'),
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Lipides'),
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Protéines'),
                                          CustomFormField(
                                              handleOnSaved: (value) => null,
                                              hintText: 'Calories'),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  model.addMeal();
                                                },
                                                child: const Text("Ajouter")),
                                          ),
                                        ]));
                          },
                          child: const Text("Ajouter un repas"))
                    ],
                  ),
                ),
              ),
            )));
  }
}
