import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/layouts/forms/custom_form_field_radio_buttons/radio_list_tile/custom_radio_list_tile.dart';

// ignore: must_be_immutable
class CustomFormFieldGender extends StatefulWidget {
  CustomFormFieldGender(
      {Key? key,
      required this.gender,
      required this.handleOnPressedRadioButton})
      : super(key: key);

  @override
  State<CustomFormFieldGender> createState() => _CustomFormFieldGenderState();

  GenderEnum gender;
  final Function(GenderEnum gender) handleOnPressedRadioButton;
}

class _CustomFormFieldGenderState extends State<CustomFormFieldGender> {
  @override
  Widget build(BuildContext context) {
    GenderEnum enumValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomRadioListTile<int>(
          value: GenderEnum.male.index,
          groupValue: widget.gender!.index,
          leading: getGenderEnumTextFromEnum(GenderEnum.male),
          onChanged: (value) => {
            enumValue = GenderEnum.values.elementAt(value),
            setState(() => {
                  widget.gender = enumValue,
                  widget.handleOnPressedRadioButton(enumValue)
                })
          },
        ),
        CustomRadioListTile<int>(
          value: GenderEnum.female.index,
          groupValue: widget.gender!.index,
          leading: getGenderEnumTextFromEnum(GenderEnum.female),
          onChanged: (value) => {
            enumValue = GenderEnum.values.elementAt(value),
            setState(() => {
                  widget.gender = enumValue,
                  widget.handleOnPressedRadioButton(enumValue)
                })
          },
        ),
        CustomRadioListTile<int>(
          value: GenderEnum.other.index,
          groupValue: widget.gender!.index,
          leading: getGenderEnumTextFromEnum(GenderEnum.other),
          onChanged: (value) => {
            enumValue = GenderEnum.values.elementAt(value),
            setState(() => {
                  widget.gender = enumValue,
                  widget.handleOnPressedRadioButton(enumValue)
                })
          },
        ),
      ],
    );
  }
}
