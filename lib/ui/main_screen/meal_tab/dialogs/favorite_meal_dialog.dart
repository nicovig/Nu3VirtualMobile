import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/models/meal_model.dart';

class FavoriteMealDialog extends StatefulWidget {
  FavoriteMealDialog(
      {Key? key,
      required this.favoritesMeals,
      required this.addFavoriteMealToDailyMeals,
      required this.deleteFavoriteMeal})
      : super(key: key);

  List<FavoriteMealModel> favoritesMeals = [];

  final Function(int, BuildContext) addFavoriteMealToDailyMeals;
  final Function(int) deleteFavoriteMeal;

  @override
  _FavoriteMealDialogState createState() => _FavoriteMealDialogState();
}

class _FavoriteMealDialogState extends State<FavoriteMealDialog> {
  int currentFavoriteMeal = 0;

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Liste des favoris',
                style: TextStyle(fontSize: 22, color: Colors.blue.shade300),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enableInfiniteScroll: false,
                initialPage: currentFavoriteMeal,
                onPageChanged: (index, reason) => currentFavoriteMeal = index,
              ),
              items: widget.favoritesMeals.map((favoriteMeal) {
                return Builder(
                  builder: (BuildContext context) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: getBorderDecoration(),
                        left: getBorderDecoration(),
                        right: getBorderDecoration(),
                        bottom: getBorderDecoration(),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getCarouselText(favoriteMeal),
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (() {
                      FavoriteMealModel favoritesMeal =
                          widget.favoritesMeals[currentFavoriteMeal];
                      widget.addFavoriteMealToDailyMeals(
                          favoritesMeal.id ?? 0, context);

                      setState(() {});
                    }),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green.shade300),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  const Spacer(),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (() {
                      FavoriteMealModel favoritesMeal =
                          widget.favoritesMeals[currentFavoriteMeal];
                      widget.deleteFavoriteMeal(favoritesMeal.id ?? 0);
                      setState(() {
                        widget.favoritesMeals.removeAt(currentFavoriteMeal);
                      });
                    }),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade300),
                    ),
                    child: const Icon(Icons.delete),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

getBorderDecoration() {
  return BorderSide.lerp(BorderSide(color: Colors.blue.shade200, width: 2),
      const BorderSide(style: BorderStyle.none), 0);
}

List<Widget> getCarouselText(FavoriteMealModel favoriteMeal) {
  List<Widget> favoriteMealTextList = [];

  favoriteMealTextList.addAll([
    const Spacer(),
    Text(
      getMealTypeEnumText(favoriteMeal.type ?? MealTypeEnum.snack),
      style: const TextStyle(fontSize: 16.0),
    ),
    const Spacer()
  ]);

  if (favoriteMeal.name != '') {
    favoriteMealTextList.addAll([
      Text(
        favoriteMeal.name ?? '',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.carbohydrate != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Glucides = ${favoriteMeal.carbohydrate}',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.lipid != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Glucides = ${favoriteMeal.lipid}',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.protein != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Glucides = ${favoriteMeal.protein}',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.calorie != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Glucides = ${favoriteMeal.calorie}',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  return favoriteMealTextList;
}
