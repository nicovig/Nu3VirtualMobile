import 'package:flutter/material.dart';

class ChangeDateButtons extends StatelessWidget {
  const ChangeDateButtons({
    Key? key,
    required this.handleOnPressedLeftButton,
    required this.handleOnPressedMiddleButton,
    required this.handleOnPressedRightButton,
  }) : super(key: key);

  final Function() handleOnPressedLeftButton;
  final Function() handleOnPressedMiddleButton;
  final Function() handleOnPressedRightButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: handleOnPressedLeftButton,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue.shade100),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue.shade50)))),
            child: const Icon(Icons.arrow_back_ios, color: Colors.blue)),
        ElevatedButton(
            onPressed: handleOnPressedMiddleButton,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue.shade100),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue.shade50)))),
            child: const Text(
              "Aujourd'hui",
              style: TextStyle(color: Colors.blue),
            )),
        ElevatedButton(
            onPressed: handleOnPressedRightButton,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue.shade100),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue.shade50)))),
            child: const Icon(Icons.arrow_forward_ios, color: Colors.blue)),
      ],
    );
  }
}
