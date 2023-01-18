import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/user_model.dart';

class CustomFormFieldGender extends StatefulWidget {
  const CustomFormFieldGender(
      {Key? key, required this.handleOnPressedRadioButton})
      : super(key: key);

  @override
  State<CustomFormFieldGender> createState() => _CustomFormFieldGenderState();

  final Function(GenderEnum gender) handleOnPressedRadioButton;
}

class _CustomFormFieldGenderState extends State<CustomFormFieldGender> {
  GenderEnum? _gender = GenderEnum.male;
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: GenderEnum.male,
                    groupValue: _gender,
                    onChanged: (GenderEnum? value) {
                      setState(() {
                        _gender = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Homme')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: GenderEnum.female,
                    groupValue: _gender,
                    onChanged: (GenderEnum? value) {
                      setState(() {
                        _gender = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Femme')
              ]))),
      Expanded(
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(children: [
                Radio(
                    value: GenderEnum.other,
                    groupValue: _gender,
                    onChanged: (GenderEnum? value) {
                      setState(() {
                        _gender = value;
                        widget.handleOnPressedRadioButton(value!);
                      });
                    }),
                const Text('Autre')
              ]))),
    ]);
  }
}
