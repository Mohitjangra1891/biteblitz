import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class bankname_textfield extends StatelessWidget {
  const bankname_textfield({
    super.key,
    required TextEditingController bankName_controller,
  }) : _bankName_controller = bankName_controller;

  final TextEditingController _bankName_controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _bankName_controller,
      onTapOutside: (event) {
        // Unfocus the TextField when tapping outside
        FocusScope.of(context).unfocus();
      },
      style: const TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w500),
      // controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search ,color: AppColors.primary_orange_color,),
        hintText: 'Enter Bank Here',
        hintStyle:  TextStyle(fontSize: 12, color:  AppColors.primary_orange_color.withOpacity(0.50), fontWeight: FontWeight.w400),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:   AppColors.primary_orange_color.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:   AppColors.primary_orange_color.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color:   AppColors.primary_orange_color.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color:   AppColors.primary_orange_color.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}




