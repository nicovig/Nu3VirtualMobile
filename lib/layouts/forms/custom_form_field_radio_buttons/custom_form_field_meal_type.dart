import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/radio_list_tile/custom_radio_list_tile.dart';

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
    MealTypeEnum enumValue;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomRadioListTile<int>(
              value: MealTypeEnum.breakfast.index,
              groupValue: _mealType!.index,
              leading: 'Petit-déjeuner',
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          _mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.brunch.index,
              groupValue: _mealType!.index,
              leading: 'Brunch',
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          _mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.lunch.index,
              groupValue: _mealType!.index,
              leading: 'Déjeuner',
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          _mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.snack.index,
              groupValue: _mealType!.index,
              leading: 'Collation',
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          _mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.dinner.index,
              groupValue: _mealType!.index,
              leading: 'Dîner',
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          _mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
        ]);
  }
}
