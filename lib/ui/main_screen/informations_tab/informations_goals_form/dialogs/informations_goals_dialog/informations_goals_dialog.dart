import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/macronutrients_text.dart';
import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:url_launcher/link.dart';

class InformationsGoalsDialog extends StatelessWidget {
  InformationsGoalsDialog({
    Key? key,
    required this.genderType,
    required this.macronutrientType,
  }) : super(key: key);

  GenderEnum genderType;
  MacronutrientTypeEnum macronutrientType;

  getMacronutrientTypeText(
    GenderEnum genderType,
    MacronutrientTypeEnum macronutrientType,
  ) {
    switch (macronutrientType) {
      case MacronutrientTypeEnum.carbohydrate:
        switch (genderType) {
          case GenderEnum.unknown:
            source = carbohydrate_unknown_source;
            return carbohydrate_unknown_text;

          case GenderEnum.male:
            source = carbohydrate_male_source;
            return carbohydrate_male_text;

          case GenderEnum.female:
            source = carbohydrate_female_source;
            return carbohydrate_female_text;

          case GenderEnum.other:
            source = carbohydrate_other_source;
            return carbohydrate_other_text;

          default:
            source = carbohydrate_unknown_source;
            return carbohydrate_unknown_text;
        }

      case MacronutrientTypeEnum.lipid:
        switch (genderType) {
          case GenderEnum.unknown:
            source = lipid_unknown_source;
            return lipid_unknown_text;

          case GenderEnum.male:
            source = lipid_male_source;
            return lipid_male_text;

          case GenderEnum.female:
            source = lipid_female_source;
            return lipid_female_text;

          case GenderEnum.other:
            source = lipid_other_source;
            return lipid_other_text;

          default:
            source = lipid_unknown_source;
            return lipid_unknown_text;
        }

      case MacronutrientTypeEnum.protein:
        switch (genderType) {
          case GenderEnum.unknown:
            source = protein_unknown_source;
            return protein_unknown_text;

          case GenderEnum.male:
            source = protein_male_source;
            return protein_male_text;

          case GenderEnum.female:
            source = protein_female_source;
            return protein_female_text;

          case GenderEnum.other:
            source = protein_other_source;
            return protein_other_text;

          default:
            source = protein_unknown_source;
            return protein_unknown_text;
        }

      case MacronutrientTypeEnum.calorie:
        switch (genderType) {
          case GenderEnum.unknown:
            source = calorie_unknown_source;
            return calorie_unknown_text;

          case GenderEnum.male:
            source = calorie_male_source;
            return calorie_male_text;

          case GenderEnum.female:
            source = calorie_female_source;
            return calorie_female_text;

          case GenderEnum.other:
            source = calorie_other_source;
            return calorie_other_text;

          default:
            source = calorie_unknown_source;
            return calorie_unknown_text;
        }
    }
  }

  String source = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Text(getMacronutrientTypeEnumText(macronutrientType)),
      children: [
        Text(getMacronutrientTypeText(genderType, macronutrientType)),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Link(
            uri: Uri.parse(source),
            builder: (_, followLink) {
              return ElevatedButton(
                onPressed: followLink,
                child: const Text('Source'),
              );
            },
          ),
        ),
      ],
    );
  }
}
