import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';

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
            return 'Glucides inconnu';

          case GenderEnum.male:
            return 'Glucides homme';

          case GenderEnum.female:
            return 'Glucides femme';

          case GenderEnum.other:
            return 'Glucides autre';

          default:
            return 'Glucides inconnu';
        }

      case MacronutrientTypeEnum.lipid:
        switch (genderType) {
          case GenderEnum.unknown:
            return 'Lipides inconnu';

          case GenderEnum.male:
            return 'Lipides homme';

          case GenderEnum.female:
            return 'Lipides femme';

          case GenderEnum.other:
            return 'Lipides autre';

          default:
            return 'Lipides inconnu';
        }

      case MacronutrientTypeEnum.protein:
        switch (genderType) {
          case GenderEnum.unknown:
            return 'Lipides inconnu';

          case GenderEnum.male:
            return 'Lipides homme';

          case GenderEnum.female:
            return 'Lipides femme';

          case GenderEnum.other:
            return 'Lipides autre';

          default:
            return 'Lipides inconnu';
        }

      case MacronutrientTypeEnum.calorie:
        switch (genderType) {
          case GenderEnum.unknown:
            return 'Lipides inconnu';

          case GenderEnum.male:
            return 'Lipides homme';

          case GenderEnum.female:
            return 'Lipides femme';

          case GenderEnum.other:
            return 'Lipides autre';

          default:
            return 'Lipides inconnu';
        }

      default:
        switch (genderType) {
          case GenderEnum.unknown:
            return 'Lipides inconnu';

          case GenderEnum.male:
            return 'Lipides homme';

          case GenderEnum.female:
            return 'Lipides femme';

          case GenderEnum.other:
            return 'Lipides autre';

          default:
            return 'Lipides inconnu';
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
          child: Text('Source: $source'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: (() => Navigator.pop(context, true)),
            child: const Text('Fermer'),
          ),
        ),
      ],
    );
  }
}
