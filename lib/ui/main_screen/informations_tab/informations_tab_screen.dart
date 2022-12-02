// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InformationsTabViewModel>.reactive(
      viewModelBuilder: () => InformationsTabViewModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          ),
          ChangeDateButtons(handleOnPressedLeftButton: (() async {
            setState(() {
              widget.date = DateTime(
                  widget.date.year, widget.date.month, widget.date.day - 1);
            });
            await model.loadData(widget.date);
            widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.left);
          }), handleOnPressedMiddleButton: (() async {
            setState(() {
              widget.date = DateTime.now();
            });
            await model.loadData(widget.date);
            widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.middle);
          }), handleOnPressedRightButton: (() async {
            setState(() {
              widget.date = DateTime(
                  widget.date.year, widget.date.month, widget.date.day + 1);
            });
            await model.loadData(widget.date);
            widget.handleOnPressedDateButton(ChangeDateButtonTypeEnum.right);
          })),
        ],
      ),
    );
  }
}
