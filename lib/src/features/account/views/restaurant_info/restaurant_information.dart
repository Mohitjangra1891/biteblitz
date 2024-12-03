import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../res/colors.dart';
import '../../../../res/strings.dart';
import '../../../../utils/router.dart';

class restaurant_information_screen extends StatelessWidget {
  const restaurant_information_screen({super.key});


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Restaurant\'s Information',
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenHeight*0.02),
            child: InkWell(
              onTap: () {

                context.pushNamed(routeNames.edit_restaurant_info );

                // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_restaurant_information_screen()));

              },
              splashColor: AppColors.primary_orange_color,
               child:Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white, // White button
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Slight shadow
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary_orange_color,
                  size: 16,
                ),
              ),
            ),
          ),
        ],

      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [


            ...restaurant_info.map((event) => info_tile(
              title: event['title']!,
              subtitle: event['subtitle']!,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            )).toList(),



          ],
        ),
      ),
    );
  }

  Container info_tile({required String title ,required String subtitle ,required double screenHeight,required double screenWidth} ) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(vertical: screenHeight*0.01),
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
               Text(
                title,
                style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
               Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
  }


}
