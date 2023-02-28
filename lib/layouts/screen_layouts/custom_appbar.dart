import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool displayDisconnectionButton;
  final Function()? handleClickOnDisconnection;

  CustomAppBar(
      {Key? key,
      required this.title,
      required this.displayDisconnectionButton,
      this.handleClickOnDisconnection})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  List<Widget> getActions(bool displayDisconnectionButton) {
    return displayDisconnectionButton
        ? [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: handleClickOnDisconnection,
                  child: const Icon(
                    Icons.exit_to_app_sharp,
                    size: 26.0,
                  ),
                ))
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: color_5,
      title: Text(
        title,
      ),
      actions: getActions(displayDisconnectionButton),
    );
  }
}
