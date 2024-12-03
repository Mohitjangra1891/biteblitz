import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/router.dart';

class verification extends StatelessWidget {
  const verification({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.03),
            child: Stack(children: [
              Center(
                child: Container(
                  width: screenHeight * 0.32, // Set the width
                  height: screenHeight * 0.32, // Set the height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.add_doc_bg), // Background image
                      fit: BoxFit.cover, // Fit the image within the container
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3), // Adjust the opacity
                        BlendMode.dstIn, // Apply the opacity as an overlay
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15), // Optional: add rounded corners
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verification & Document Submission',
                    style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Thank you for signing up with BiteBlitz!',
                    style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    'To complete the registration process, please verify your restaurant and provide the following documents:',
                    style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    '1. PAN Card Copy 2.Bank Account Details 3. Restaurant Menu and Dish Images (Top Items) 4. FSSAI and GSTIN Registration Copies (if applicable) 5. Business Registration Certificate (if available)',
                    style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  button_Primary(
                    title: "Continue",
                    onPressed: () {
                      context.pushNamed(routeNames.addPan);

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const pan_card()));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
