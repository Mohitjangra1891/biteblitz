import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:biteblitz/src/utils/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/router.dart';
import '../../../utils/validators.dart';
import '../controllers/auth_controller.dart';

class add_res_Info_Screen extends ConsumerStatefulWidget {
  const add_res_Info_Screen({super.key});

  @override
  ConsumerState<add_res_Info_Screen> createState() => _add_res_Info_ScreenState();
}

class _add_res_Info_ScreenState extends ConsumerState<add_res_Info_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  final GlobalKey<textField_widgetState> _ownerNameFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _addressFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _emaiFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<NumericTextFieldState> _phoneFieldKey = GlobalKey<NumericTextFieldState>();

  final TextEditingController _ownerName_controller = TextEditingController();
  TextEditingController _address_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setEmail();

    super.initState();
  }

  void setEmail() async {
    String? value = await SharedPrefHelper.getValue(SharedPrefKeys.restaurantEmail);
    print('Retrieved email: $value');
    _email_controller.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final resInfoState = ref.watch(addBankDetailsStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      'Restaurant Information',
                      style: TextStyle(fontSize: 24, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      'Restaurant must provide valid details, follow food safety standards. Both parties can end the partnership with notice.',
                      style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    textField_widget(
                        title: "Owner/Manager Name",
                        key: _ownerNameFieldKey,
                        validator: (value) => Validators.notEmpty(value, "Owner Name"),
                        controller: _ownerName_controller),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(
                        title: "Address",
                        key: _addressFieldKey,
                        validator: (value) => Validators.notEmpty(value, "Address"),
                        controller: _address_controller),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(title: "Email Address", key: _emaiFieldKey, isreadOnly: true, controller: _email_controller),
                    SizedBox(height: screenHeight * 0.02),
                    NumericTextField(
                        title: "Phone",
                        key: _phoneFieldKey,
                        validator: (value) => Validators.notEmpty(value, "Phone Number"),
                        controller: _phone_controller),
                    SizedBox(height: screenHeight * 0.02),
                    const Spacer(),
                    resInfoState.when(
                      data: (_) {
                        return button_Primary(
                          title: "Next",
                          onPressed: () async {
                            final isNameValid = _ownerNameFieldKey.currentState?.validate() ?? false;
                            final isNumberValid = _phoneFieldKey.currentState?.validate() ?? false;
                            final isAddreessValid = _addressFieldKey.currentState?.validate() ?? false;
                            final isEmailValid = _emaiFieldKey.currentState?.validate() ?? false;

                            if (isNameValid && isNumberValid && isAddreessValid && isEmailValid) {
                              // await ref.read(authProvider.notifier).addBankDetails(ref, context,
                              //     accNumber: _email_controller.text.trim(),
                              //     bankName: _ownerName_controller.text..trim(),
                              //     ifsc_code: _phone_controller.text.trim());
                              SharedPrefHelper.saveValue(SharedPrefKeys.onboarding_stage, 2);

                              context.pushNamed(routeNames.addPan);

                              _ownerName_controller.clear();
                              _address_controller.clear();
                              _email_controller.clear();
                              _phone_controller.clear();
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
