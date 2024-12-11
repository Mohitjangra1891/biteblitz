// Reusable Function to Show Dialog
import 'package:biteblitz/src/utils/SharedPrefHelper.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class CustomDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      elevation: 2.0,
      // backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenHieght * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.primary_orange_color,
                  size: 16,
                ),
                SizedBox(width: screenWidth * 0.02),
                const Text(
                  'Delete Item',
                  style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: screenHieght * 0.02),
            const Text(
              "Are you sure you want to delete this item?",
              style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: screenHieght * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      side: const BorderSide(
                        color: AppColors.primary_orange_color,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: screenHieght * 0.02),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary_orange_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class logout_Dailog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      elevation: 2.0,
      // backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenHieght * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_outlined,
                  color: AppColors.primary_orange_color,
                  size: 16,
                ),
                SizedBox(width: screenWidth * 0.02),
                const Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: screenHieght * 0.02),
            const Text(
              "Are you sure you want to Logout?",
              style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: screenHieght * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      side: const BorderSide(
                        color: AppColors.primary_orange_color,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'No',
                      style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: screenHieght * 0.02),
                ElevatedButton(
                  onPressed: () {
                    SharedPrefHelper.removeToken(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary_orange_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Yes',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
