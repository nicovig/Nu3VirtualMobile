import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/meal_model.dart';

class CustomFormFieldMealType extends StatefulWidget {
  const CustomFormFieldMealType(
      {Key? key, required this.handleOnPressedRadioButton})
      : super(key: key);

  @override
  State<CustomFormFieldMealType> createState() =>
      _CustomFormFieldMealTypeState();

  final Function(MealTypeEnum mealType) handleOnPressedRadioButton;
}

class _CustomFormFieldMealTypeState extends State<CustomFormFieldMealType> {
  MealTypeEnum? _mealType = MealTypeEnum.lunch;
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: MealTypeEnum.breakfast,
                    groupValue: _mealType,
                    onChanged: (MealTypeEnum? value) {
                      setState(() {
                        _mealType = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Petit-déjeuner')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: MealTypeEnum.brunch,
                    groupValue: _mealType,
                    onChanged: (MealTypeEnum? value) {
                      setState(() {
                        _mealType = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Brunch')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: MealTypeEnum.lunch,
                    groupValue: _mealType,
                    onChanged: (MealTypeEnum? value) {
                      setState(() {
                        _mealType = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Déjeuner')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: MealTypeEnum.snack,
                    groupValue: _mealType,
                    onChanged: (MealTypeEnum? value) {
                      setState(() {
                        _mealType = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Collation')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: MealTypeEnum.dinner,
                    groupValue: _mealType,
                    onChanged: (MealTypeEnum? value) {
                      setState(() {
                        _mealType = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Dîner')
              ]))),
    ]);
  }
}
