import 'package:biteblitz/src/features/account/views/widgets/account%20list%20item.dart';
import 'package:biteblitz/src/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../res/colors.dart';
import '../../../res/imges.dart';
import '../../../utils/router.dart';

class account_screen extends StatelessWidget {
  const account_screen({super.key});

  @override
  Widget build(BuildContext context) {


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            Stack(children: [
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.round_logo,
                      height: screenHeight * 0.08,
                      width: screenHeight * 0.08,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: screenHeight * 0.02,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant_Name,
                          style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          restaurant_Email,
                          style: TextStyle(fontSize: 11, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          restaurant_Mobile,
                          style: TextStyle(fontSize: 11, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child: InkWell(
                      splashColor: Colors.white,
                      // inkwell color
                      child: const SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(
                            Icons.logout_rounded,
                            color: AppColors.primary_orange_color,
                            size: 22,
                          )),
                      onTap: () {
                      },
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(routeNames.restaurant_info );


                    },
                    child: Container(
                      padding: EdgeInsets.all(screenHeight * 0.02),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const ClipOval(
                            child: Material(
                              color: Color.fromRGBO(255, 87, 51, 0.12),
                              child: SizedBox(
                                  width: 34,
                                  height: 34,
                                  child:   Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColors.primary_orange_color,
                                    size: 18,
                                  ),),
                            ),
                          ),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          const Text(
                            'Restaurant\'s Information',
                            style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.02,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(routeNames.setting );


                    },
                    child: Container(
                      padding: EdgeInsets.all(screenHeight * 0.02),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const ClipOval(
                            child: Material(
                              color: Color.fromRGBO(255, 87, 51, 0.12),
                              child: SizedBox(
                                width: 34,
                                height: 34,
                                child:   Icon(
                                  Icons.settings_rounded ,
                                  color: AppColors.primary_orange_color,
                                  size: 18,
                                ),),
                            ),
                          ),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          const Text(
                            'Settings',
                            style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {

                context.pushNamed(routeNames.bank_Acc_details );

              },
              title: 'Bank Account Details',
              icon: Icons.food_bank,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {

                context.pushNamed(routeNames.helpandSupport );

              },
              title: 'Help & Support',
              icon: Icons.help_outline,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {

                context.pushNamed(routeNames.contactUs );

              },
              title: 'Contact Us',
              icon: Icons.person,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {
                context.pushNamed(routeNames.feedback );

                // Navigator.push(context, MaterialPageRoute(builder: (context)=>feedback_screen()));

              },
              title: 'Feedback',
              icon: Icons.comment_outlined,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ))),
    );
  }
}
