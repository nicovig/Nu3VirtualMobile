import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text('Chargement en cours')
              ]))
        ]));
  }
}
