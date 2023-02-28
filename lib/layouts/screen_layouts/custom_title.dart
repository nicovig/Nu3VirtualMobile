import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      child: Text(title,
          style: const TextStyle(
            color: color_5,
            fontSize: 26,
          )),
    );
  }
}
