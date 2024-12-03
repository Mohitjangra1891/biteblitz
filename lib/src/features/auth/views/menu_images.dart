import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/services/imagePicker/imagePickerService.dart';
import '../../../utils/router.dart';

class menu_images extends StatelessWidget {
  const menu_images({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
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
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.45), // Adjust the opacity
                        BlendMode.dstATop, // Apply the opacity as an overlay
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
                    'Restaurant Menu Images',
                    style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Restaurant menu images are needed to showcase the variety of dishes offered by the restaurant on the BiteBlitz platform.',
                    style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  upload_button(
                    onPressed: () async {
                      final images = await imagePickerService.pickMultipleImages();
                      print("Picked license image is --$images");
                    },
                    title: 'Upload Menu Card Images',
                  ),
                  const Spacer(),
                  button_Primary(
                    title: "Next",
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const fssai_screen()));
                      context.pushNamed(routeNames.addFssai);
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
