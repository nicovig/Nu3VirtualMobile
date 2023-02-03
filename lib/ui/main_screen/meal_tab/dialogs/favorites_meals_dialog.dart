import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:nu3virtual/core/models/meal_model.dart';

class FavoritesMealsDialog extends StatefulWidget {
  final Function(MealModel, BuildContext) handleValidation;
  int userId = 0;
  DateTime date = DateTime.now();

  FavoritesMealsDialog(
      {Key? key,
      required this.handleValidation,
      required this.userId,
      required this.date})
      : super(key: key);

  @override
  _FavoritesMealsDialogState createState() => _FavoritesMealsDialogState();
}

class _FavoritesMealsDialogState extends State<FavoritesMealsDialog> {
  @override
  initState() {
    //final mealToUpdate = widget.mealToUpdate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      SizedBox(
        width: 450,
        height: 400,
        child: CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
