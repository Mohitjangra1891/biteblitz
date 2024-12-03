import 'dart:io';

import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/imagePicker/imagePickerService.dart';
import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/validators.dart';
import '../controllers/auth_controller.dart';

class add_gstIN_screen extends ConsumerStatefulWidget {
  const add_gstIN_screen({super.key});

  @override
  ConsumerState<add_gstIN_screen> createState() => _gstIN_screenState();
}

class _gstIN_screenState extends ConsumerState<add_gstIN_screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  TextEditingController _gstNum_controller = TextEditingController();

// Declare the GlobalKeys in your screen (e.g., LoginScreen)
  final GlobalKey<textField_widgetState> _gstNumFieldKey = GlobalKey<textField_widgetState>();

  @override
  Widget build(BuildContext context) {
    final gstInState = ref.watch(addgstInStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Focus.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
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
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GSTIN or Registration',
                        style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'The GSTIN or its registration document is necessary for tax compliance purposes and to ensure that the restaurant is registered under the Goods and Services Tax regime.',
                        style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      textField_widget(
                        title: "GSTIN Number",
                        key: _gstNumFieldKey,
                        controller: _gstNum_controller,
                        validator: (value) => Validators.notEmpty(value, "GSTIN Number"),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      upload_button(
                        onPressed: () async {
                          final File? pickedImage = await imagePickerService.pickImageFromGallery();
                          print("Picked license image is --$pickedImage");
                        },
                        title: 'Upload License/Registration Copy',
                      ),
                      const Spacer(),
                      gstInState.when(
                        data: (_) {
                          return button_Primary(
                            title: "Finish",
                            onPressed: () async {
                              final isGstNUmValid = _gstNumFieldKey.currentState?.validate() ?? false;

                              if (isGstNUmValid) {
                                await ref.read(authProvider.notifier).addgstIn(ref, context, gstNumber: _gstNum_controller.text.trim(), gstImage: "gstImage");
                                _gstNum_controller.clear();

                              }

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
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
