import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/features/auth/controllers/auth_controller.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/validators.dart';

class bank_details extends ConsumerStatefulWidget {
  const bank_details({super.key});

  @override
  ConsumerState<bank_details> createState() => _bank_detailsState();
}

class _bank_detailsState extends ConsumerState<bank_details> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  final GlobalKey<textField_widgetState> _bankNameFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _accNumberFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _confirm_accNumFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _ifscCodeFieldKey = GlobalKey<textField_widgetState>();

  TextEditingController _bankname_controller = TextEditingController();
  TextEditingController _accNum_controller = TextEditingController();
  TextEditingController _confirm_accNum_controller = TextEditingController();
  TextEditingController _ifscCode_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bankdetailState = ref.watch(addBankDetailsStateProvider);


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
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
                      'Bank Account Details',
                      style:
                          TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      'Bank account details are necessary for processing payments and facilitating transactions between the restaurant and BiteBlitz.',
                      style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    textField_widget(
                        title: "Bank Name",
                        key: _bankNameFieldKey,
                        validator: (value) => Validators.notEmpty(value, "Bank Name"),
                        controller: _bankname_controller),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(
                        title: "Account Number",
                        key: _accNumberFieldKey,
                        validator: (value) => Validators.notEmpty(value, "Account Number"),
                        controller: _accNum_controller),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(
                        title: "Confirm Account Number",
                        key: _confirm_accNumFieldKey,
                        validator: (value) =>
                            Validators.confirmBankAccountNUmberValidator(value, _accNum_controller.text.trim()),
                        controller: _confirm_accNum_controller),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(
                        title: "IFSC Code",
                        key: _ifscCodeFieldKey,
                        validator: (value) => Validators.notEmpty(value, "IFSC Code"),
                        controller: _ifscCode_controller),
                    SizedBox(height: screenHeight * 0.02),
                    const Spacer(),
                    bankdetailState.when(
                      data: (_) {
                        return  button_Primary(
                          title: "Next",
                          onPressed: () async {
                            final isNameValid = _bankNameFieldKey.currentState?.validate() ?? false;
                            final isIfscValid = _ifscCodeFieldKey.currentState?.validate() ?? false;
                            final isAccNumValid = _accNumberFieldKey.currentState?.validate() ?? false;
                            final isConfirmAccNumValid = _confirm_accNumFieldKey.currentState?.validate() ?? false;

                            if (isNameValid && isIfscValid && isAccNumValid && isConfirmAccNumValid) {
                              await ref.read(authProvider.notifier).addBankDetails(ref, context,
                                  accNumber: _confirm_accNum_controller.text.trim(),
                                  bankName: _bankname_controller.text..trim(),
                                  ifsc_code: _ifscCode_controller.text.trim());

                              _bankname_controller.clear();
                              _accNum_controller.clear();
                              _confirm_accNum_controller.clear();
                              _ifscCode_controller.clear();
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
    );
  }
}
