import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

class button_Primary extends StatelessWidget {

  const button_Primary({super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return   ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth, screenHeight * 0.06),
        backgroundColor: AppColors.primary_orange_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}


class upload_button extends StatelessWidget {

  const upload_button({super.key, required this.onPressed, required this.title , this.icon});
  final VoidCallback onPressed;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return   ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth*0.20, screenHeight * 0.05),
        backgroundColor: AppColors.primary_orange_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(icon ?? Icons.upload_file_rounded,color: Colors.white, size: 16,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:  5.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
