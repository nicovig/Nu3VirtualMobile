// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/ui/main_screen/informations_tab/informations_tab_viewmodel.dart';

// ignore: must_be_immutable
class InformationsTabScreen extends StatefulWidget {
  InformationsTabScreen(
      {super.key, required this.date, required this.handleOnPressedDateButton});

  @override
  _InformationsTabScreenState createState() => _InformationsTabScreenState();

  DateTime date;
  final Function(ChangeDateButtonTypeEnum type) handleOnPressedDateButton;
}

class _InformationsTabScreenState extends State<InformationsTabScreen> {
  static const double spaceBetweenLinesPersonnalInformations = 6;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InformationsTabViewModel>.reactive(
      viewModelBuilder: () => InformationsTabViewModel(),
      onViewModelReady: (model) {
        EasyLoading.show();
        model.initData(widget.date);
      },
      builder: (context, model, child) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          ),
          ChangeDateButtons(
            handleOnPressedLeftButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime(
                    widget.date.year, widget.date.month, widget.date.day - 1);
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.left);
              EasyLoading.dismiss(animation: false);
            }),
            handleOnPressedMiddleButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime.now();
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.middle);
              EasyLoading.dismiss(animation: false);
            }),
            handleOnPressedRightButton: (() async {
              EasyLoading.show();
              setState(() {
                widget.date = DateTime(
                    widget.date.year, widget.date.month, widget.date.day + 1);
              });
              await model.loadData(widget.date);
              widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.right);
              EasyLoading.dismiss(animation: false);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                    style: const TextStyle(fontSize: 20),
                    DateFormat('EEEE d MMMM yyyy')
                        .format(widget.date)
                        .toString()),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getDataGoalsWidgetList(model),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {}),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade200)),
                  child: const Text('Modifier mes objetctifs'),
                ),
                const Divider(height: 30),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Mes informations',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Pseudo :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Prénom :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Nom :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Genre :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Date de naissance :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Taille :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Poids :'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text('Taille :'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text(model.user.pseudo ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text(model.user.firstName ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text(model.user.lastName ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child: Text(
                                    getGenderEnumText(model.user.gender ?? 0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child:
                                    Text(getUserBirthday(model.user.birthday)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child:
                                    Text(getUserHeight(model.user.height ?? 0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        spaceBetweenLinesPersonnalInformations),
                                child:
                                    Text(getUserWeight(model.user.weight ?? 0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(model.user.email ?? ''),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      ElevatedButton(
                        onPressed: (() {}),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blue.shade200)),
                        child: const Text('Modifier mes informations'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getDataGoalsWidgetList(InformationsTabViewModel model) {
  List<Widget> list = [];
  EasyLoading.show();
  for (var i = 0; i < model.informationGoals.length; i++) {
    var informationGoal = model.informationGoals[i];
    list.add(
      Column(
        children: [
          Text(informationGoal.name ?? ''),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            strokeWidth: 6,
            value: double.parse(
              (informationGoal.achievedRatio ?? 0).toString(),
            ),
            backgroundColor: Colors.red,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          const SizedBox(height: 20),
          Text(
              '${informationGoal.achievedValue}/${informationGoal.totalValue}'),
        ],
      ),
    );
  }
  EasyLoading.dismiss(animation: false);
  return list;
}

String getUserBirthday(DateTime? birthday) {
  if (birthday != null) {
    return '${birthday.day}/${birthday.month}/${birthday.year}';
  }
  return '';
}

String getUserHeight(int heightUser) {
  return '$heightUser cm';
}

String getUserWeight(num weightUser) {
  return '$weightUser kg';
}
