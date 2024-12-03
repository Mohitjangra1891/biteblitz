
// Helper method to build each support tile
import 'package:flutter/material.dart';

import '../../../../res/colors.dart';

Widget buildSupportTile(String question ,String answer) {
  return Theme(
    data: ThemeData().copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      expansionAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 350),

      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment : Alignment.topLeft,
      visualDensity: VisualDensity.compact,
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.dark_text_color,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.dark_text_color),

      children:  [
        Text(
          answer,
          style: const TextStyle(  fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.dark_light_text_color,),
        ),
      ],
    ),
  );
}
