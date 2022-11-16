import 'package:flutter/material.dart';

import 'package:nu3virtual/core/helpers/helpers.dart';

class MonitoringBox extends StatelessWidget {
  MonitoringBox({
    Key? key,
    required this.date,
    required this.monitoring,
  }) : super(key: key);
  final DateTime date;
  final String monitoring;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          border: Border.all(
            color: Colors.blue.shade200,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            getMonitoringDate(date),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Calories consommées : 500", style: TextStyle(fontSize: 17)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Glucides : 500", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text("Lipides : 500", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text("Protéines : 500", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ]),
    );
  }
}
