import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/features/account/views/widgets/help_expansion_tile.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

import '../../../common/views/widgets/appBar.dart';
import 'live_chat_screen/live_chat_screen.dart';

class helpSupportScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:  const appbar(
          title: 'Help & Support',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            // First Question
            shadowContainer(
                padding: EdgeInsets.symmetric(horizontal: screenHeight*0.02),
                child: buildSupportTile('How do I update my menu?' ,'This is a placeholder answer for updating the menu.')),
            SizedBox(height:  screenHeight * 0.02),
            // Second Question
            shadowContainer(padding: EdgeInsets.symmetric(horizontal: screenHeight*0.02),child: buildSupportTile('How can I track my orders?','This is a placeholder answer for tracking the Orders.')),
          ],
        ),
      ),
      // Floating Action Button for additional help
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary_orange_color,

        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>live_chatHelp_screen()));


        },
        child: const Icon(Icons.chat_outlined, color: Colors.white),
      ),
    );
  }

}

