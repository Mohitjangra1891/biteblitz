import 'dart:io';

import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/features/auth/controllers/auth_controller.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/imagePicker/imagePickerService.dart';

class add_fssai_Screen extends ConsumerStatefulWidget {
  const add_fssai_Screen({super.key});

  @override
  ConsumerState<add_fssai_Screen> createState() => _add_fssai_ScreenState();
}

class _add_fssai_ScreenState extends ConsumerState<add_fssai_Screen> {
  @override
  Widget build(BuildContext context) {
    final addFssaiState = ref.watch(addFssaiStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: Stack(
                children:[
                  Center(
                    child: Container(
                      width: screenHeight * 0.32, // Set the width
                      height:screenHeight * 0.32, // Set the height
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
                      ),),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'FSSAI License or Registration',
                        style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'The FSSAI license or registration document is required to ensure that the restaurant complies with food safety regulations set by the Food Safety and Standards Authority of India.',
                        style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.04),


                      upload_button(onPressed: ()  async {
                        final File? pickedImage = await imagePickerService.pickImageFromGallery();
                        print("Picked license image is --$pickedImage");  }, title: 'Upload License/Registration Copy',),
                      const Spacer(),
                      addFssaiState.when(
                        data: (_) {
                          return button_Primary(
                            title: "Next",
                            onPressed: () async {

                                await ref.read(authProvider.notifier).addfssai(ref, context, fssaiImage: "Fssai Image");



                            },
                          );
                        },
                        loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary_orange_color,
                            )),
                        error: (err, _) => Text('Error: $err'),
                      ),

                    ],
                  ),]
            ),
          ),
        ),
      ),
    );
  }
}
