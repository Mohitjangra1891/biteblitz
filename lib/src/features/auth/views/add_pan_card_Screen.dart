import 'dart:io';

import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/features/auth/controllers/auth_controller.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/imagePicker/imagePickerService.dart';
import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/validators.dart';

class add_panCard_Screen extends ConsumerStatefulWidget {
  const add_panCard_Screen({super.key});

  @override
  ConsumerState<add_panCard_Screen> createState() => _add_panCard_ScreenState();
}

class _add_panCard_ScreenState extends ConsumerState<add_panCard_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key
// Declare the GlobalKeys in your screen (e.g., LoginScreen)
  final GlobalKey<textField_widgetState> _panCard_num_FieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _panCard_name_FieldKey = GlobalKey<textField_widgetState>();

  TextEditingController _panCard_num_controller = TextEditingController();
  TextEditingController _panCard_name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final panState = ref.watch(addPanCardStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: Form(
                key: _formKey,
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
                        'PAN Card Copy',
                        style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'The PAN card copy is required for identity verification and to ensure that the restaurant is a legitimate business entity.',
                        style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      textField_widget(
                        title: "PAN Card Number",
                        key: _panCard_num_FieldKey,
                        validator: (value) => Validators.notEmpty(value, "Pan Number"),
                        controller: _panCard_num_controller,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      textField_widget(
                        title: "Card Holder's Name",
                        key: _panCard_name_FieldKey,
                        validator: (value) => Validators.notEmpty(value, "Pan Name"),
                        controller: _panCard_name_controller,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      upload_button(
                        onPressed: () async {
                          final File? pickedImage = await imagePickerService.pickImageFromGallery();
                          print("Picked license image is --$pickedImage");
                        },
                        title: 'Upload PAN Card Copy',
                      ),
                      const Spacer(),
                      panState.when(
                        data: (_) {
                          return  button_Primary(
                            title: "Next",
                            onPressed: () async {
                              final isPanNumValid = _panCard_num_FieldKey.currentState?.validate() ?? false;
                              final isPanNameValid = _panCard_name_FieldKey.currentState?.validate() ?? false;

                              if (isPanNumValid && isPanNameValid) {
                                await ref.read(authProvider.notifier).addPanCard(ref, context ,panName: _panCard_name_controller.text.trim(),panNumber: _panCard_num_controller.text.trim() ,imageUrl: "sss");


                                _panCard_num_controller.clear();
                                _panCard_name_controller.clear();
                              }

                              // context.pushNamed(routeNames.verification);
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
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
