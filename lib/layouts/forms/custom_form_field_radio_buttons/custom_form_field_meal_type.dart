import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/radio_list_tile/custom_radio_list_tile.dart';

class CustomFormFieldMealType extends StatefulWidget {
  CustomFormFieldMealType(
      {Key? key,
      required this.mealType,
      required this.handleOnPressedRadioButton})
      : super(key: key);

  @override
  State<CustomFormFieldMealType> createState() =>
      _CustomFormFieldMealTypeState();

  MealTypeEnum mealType;
  final Function(MealTypeEnum mealType) handleOnPressedRadioButton;
}

class _CustomFormFieldMealTypeState extends State<CustomFormFieldMealType> {
  @override
  Widget build(BuildContext context) {
    MealTypeEnum enumValue;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomRadioListTile<int>(
              value: MealTypeEnum.breakfast.index,
              groupValue: widget.mealType!.index,
              leading: getMealTypeEnumText(MealTypeEnum.breakfast),
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          widget.mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.brunch.index,
              groupValue: widget.mealType!.index,
              leading: getMealTypeEnumText(MealTypeEnum.brunch),
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          widget.mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.lunch.index,
              groupValue: widget.mealType!.index,
              leading: getMealTypeEnumText(MealTypeEnum.lunch),
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          widget.mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.snack.index,
              groupValue: widget.mealType!.index,
              leading: getMealTypeEnumText(MealTypeEnum.snack),
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          widget.mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
          CustomRadioListTile<int>(
              value: MealTypeEnum.dinner.index,
              groupValue: widget.mealType!.index,
              leading: getMealTypeEnumText(MealTypeEnum.dinner),
              onChanged: (value) => {
                    enumValue = MealTypeEnum.values.elementAt(value),
                    setState(() => {
                          widget.mealType = enumValue,
                          widget.handleOnPressedRadioButton(enumValue)
                        })
                  }),
        ]);
  }
}
