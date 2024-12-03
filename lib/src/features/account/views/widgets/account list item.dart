import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

class account_list_item extends StatelessWidget {
  const account_list_item({super.key, required this.onPressed, required this.title ,required this.icon});
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.all(screenHeight * 0.02),
        // margin: EdgeInsets.all(screenHeight * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primary_orange_color,
              size: 18,
            ),
            SizedBox(
              width: screenHeight * 0.01,
            ),
             Text(
              title,
              style: TextStyle(fontSize: 14, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
