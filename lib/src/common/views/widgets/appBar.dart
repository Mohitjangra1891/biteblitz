import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class appbar extends StatelessWidget {
  final String title;
  const appbar({super.key , required this.title});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(

      padding:  EdgeInsets.symmetric( vertical:screenHeight*0.01 ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Colors.white,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white, // White button
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary_orange_color.withOpacity(0.2), // Slight shadow
                    spreadRadius: 0.2,
                    blurRadius: 5,
                    offset: Offset(0, 0), // Shadow position
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary_orange_color,
                size: 16,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:  screenHeight*0.01 , ),

            child: Text(
              " $title",
              style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
