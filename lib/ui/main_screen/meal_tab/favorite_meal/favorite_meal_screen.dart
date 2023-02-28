import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:stacked/stacked.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/helpers/helpers.dart';
import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/custom_form_field_meal_type.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_appbar.dart';
import 'package:nu3virtual/layouts/screen_layouts/custom_title.dart';
import 'package:nu3virtual/layouts/screen_layouts/loading_box.dart';
import 'package:nu3virtual/ui/main_screen/meal_tab/favorite_meal/favorite_meal_viewmodel.dart';

class FavoriteMealScreen extends StatefulWidget {
  FavoriteMealScreen({Key? key}) : super(key: key);

  @override
  _FavoriteMealScreenState createState() => _FavoriteMealScreenState();
}

class _FavoriteMealScreenState extends State<FavoriteMealScreen> {
  int currentFavoriteMeal = 0;
  bool areSlidesDisplayed = false;
  MealTypeEnum mealType = getDefaultMealType();
  List<Widget> slides = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> getCarouselSlides(FavoriteMealViewModel model,
        List<FavoriteMealModel>? favoriteMeals, MealTypeEnum currentMealType) {
      model.favoritesMealsDisplayed = [];
      slides = [];
      if (favoriteMeals != null) {
        for (var favoriteMeal in favoriteMeals) {
          if (favoriteMeal.type == currentMealType) {
            model.favoritesMealsDisplayed.add(favoriteMeal);
            slides.add(
              Builder(
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
              ),
            );
          }
        }
      }

      if (slides.isNotEmpty) {
        areSlidesDisplayed = true;
      } else {
        areSlidesDisplayed = false;
        slides.add(
          Builder(
            builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Pas encore de favoris pour les ${getMealTypeEnumText(mealType).toLowerCase()}s')
                ],
              ),
            ),
          ),
        );
      }

      return slides;
    }

    return ViewModelBuilder<FavoriteMealViewModel>.reactive(
      viewModelBuilder: () => FavoriteMealViewModel(),
      builder: (context, model, child) =>
          FutureBuilder<List<FavoriteMealModel>>(
        future: model.loadData(),
        builder: (BuildContext context,
                AsyncSnapshot<List<FavoriteMealModel>> snapshot) =>
            Scaffold(
          appBar: CustomAppBar(
              title: snapshot.hasData
                  ? '${model.user.firstName} - ${model.user.weight}kg'
                  : '',
              displayDisconnectionButton: false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomTitle(title: "Liste des favoris"),
                snapshot.hasData
                    ? Column(
                        children: [
                          CustomFormFieldMealType(
                              mealType: mealType,
                              handleOnPressedRadioButton: (MealTypeEnum value) {
                                mealType = value;
                                setState(() {});
                              }),
                          CarouselSlider(
                              options: CarouselOptions(
                                height: 300,
                                enableInfiniteScroll: false,
                                initialPage: currentFavoriteMeal,
                                onPageChanged: (index, reason) =>
                                    currentFavoriteMeal = index,
                              ),
                              items: getCarouselSlides(
                                  model, snapshot.data, mealType)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: areSlidesDisplayed
                                  ? [
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: (() {
                                          FavoriteMealModel favoritesMeal =
                                              model.favoritesMealsDisplayed[
                                                  currentFavoriteMeal];
                                          model.addFavoriteMealToDailyMeals(
                                              context, favoritesMeal.id ?? 0);
                                          setState(() {});
                                        }),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  color_3),
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                      const Spacer(),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: (() {
                                          FavoriteMealModel favoritesMeal =
                                              model.favoritesMealsDisplayed[
                                                  currentFavoriteMeal];
                                          model.deleteFavoriteMeal(
                                              context, favoritesMeal.id ?? 0);
                                          setState(() {
                                            snapshot.data
                                                ?.removeAt(currentFavoriteMeal);
                                          });
                                        }),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  color_red),
                                        ),
                                        child: const Icon(Icons.delete),
                                      ),
                                      const Spacer(),
                                    ]
                                  : [const SizedBox.shrink()],
                            ),
                          ),
                        ],
                      )
                    : const LoadingBox(),
              ],
            ),
          ),
        ),
      ),
    );
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
        'Glucides: ${favoriteMeal.carbohydrate}g',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.lipid != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Lipides: ${favoriteMeal.lipid}g',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.protein != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Protéines: ${favoriteMeal.protein}g',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  if (favoriteMeal.calorie != 0) {
    favoriteMealTextList.addAll([
      Text(
        'Calories = ${favoriteMeal.calorie}',
        style: const TextStyle(fontSize: 16.0),
      ),
      const Spacer(),
    ]);
  }

  return favoriteMealTextList;
}
