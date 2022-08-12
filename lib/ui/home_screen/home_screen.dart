import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_date.dart';
import 'package:nu3virtual/ui/meal_dialog/meal_dialog.dart';
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp('[a-zA-Z0-9.]'),
                                                )
                                              ],
                                              handleOnSaved: (value) => null,
                                              hintText: 'Nom'),
                                          CustomFormFieldDate(
                                              firstDate: DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month - 1,
                                                  DateTime.now().day),
                                              label: 'Date de naissance',
                                              lastDate: DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month + 1,
                                                  DateTime.now().day),
                                              handleOnSaved: (value) {
                                                if (value != null) null;
                                              }),
                                          CustomFormField(
                                            hintText: 'Glucides',
                                            handleOnSaved: (value) {
                                              if (value != null)
                                                double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9\.-]"),
                                              )
                                            ],
                                            keyboardType: TextInputType.number,
                                          ),
                                          CustomFormField(
                                            hintText: 'Lipides',
                                            handleOnSaved: (value) {
                                              if (value != null)
                                                double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9\.-]"),
                                              )
                                            ],
                                            keyboardType: TextInputType.number,
                                          ),
                                          CustomFormField(
                                            hintText: 'Protéines',
                                            handleOnSaved: (value) {
                                              if (value != null)
                                                double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9\.-]"),
                                              )
                                            ],
                                            keyboardType: TextInputType.number,
                                          ),
                                          CustomFormField(
                                            hintText: 'Calories',
                                            handleOnSaved: (value) {
                                              if (value != null)
                                                double.parse(value);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9]"),
                                              )
                                            ],
                                            keyboardType: TextInputType.number,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  //model.addMeal();
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
