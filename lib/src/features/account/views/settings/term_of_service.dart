import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../../common/views/widgets/appBar.dart';
import '../../../../common/views/widgets/button.dart';
import '../../../../res/colors.dart';

class term_of_service extends StatelessWidget {
  const term_of_service({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Term of Service',
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            children: [
              // Spacer(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(bottom: screenHeight*0.02),
                        child: shadowContainer(
                          color: AppColors.primary_orange_color,
                          child:const Text(
                            'Our Privacy Policy explains how we collect, use, and disclose your personal information when you use our Services. By using our Services, you agree to the collection and use of your information in accordance with this policy. ',
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: screenHeight*0.02),
                        child: shadowContainer(
                          child:const Text(
                            'Your Use of the Services: You must be at least 18 years old to use our Services. You are responsible for maintaining the confidentiality of your account credentials. You agree not to engage in any illegal or unauthorized activity while using our Services.',
                            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text(
                'Please read these Terms carefully before using our Services. If you have any questions or concerns, please contact us at [contact email].',
                style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              button_Primary(
                onPressed: () {},
                title: 'Accept',
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
            ],
          )),
    );
  }
}
