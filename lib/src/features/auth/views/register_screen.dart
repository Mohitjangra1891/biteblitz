import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/router.dart';
import '../../../utils/validators.dart';
import '../controllers/auth_controller.dart';

class register_screen extends ConsumerStatefulWidget {
  const register_screen({super.key});

  @override
  ConsumerState<register_screen> createState() => _register_screenState();
}

class _register_screenState extends ConsumerState<register_screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

// Declare the GlobalKeys in your screen (e.g., LoginScreen)
  final GlobalKey<textField_widgetState> _nameFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _emailFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _passwordFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _confirmpasswordFieldKey = GlobalKey<textField_widgetState>();

  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _pass_controller = TextEditingController();
  TextEditingController _confirm_pass_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenHeight * 0.08,
                      height: screenHeight * 0.08,
                      child: Image.asset(
                        AppImages.round_logo,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create an Account',
                          style: TextStyle(fontSize: 36, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Join BiteBlitz to expand your reach',
                          style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        textField_widget(
                          key: _nameFieldKey,
                          validator: (value) => Validators.notEmpty(value, "Name"),
                          title: "Full Name",
                          controller: _name_controller,
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        textField_widget(
                            title: "Email Address",
                            key: _emailFieldKey,
                            validator: (value) => Validators.email(value),
                            controller: _email_controller),
                        SizedBox(height: screenHeight * 0.02),
                        textField_widget(
                            key: _passwordFieldKey,
                            validator: (value) => Validators.validatePassword(value),
                            title: "New Password",
                            isobsecure: true,
                            controller: _pass_controller),
                        SizedBox(height: screenHeight * 0.02),
                        textField_widget(
                            key: _confirmpasswordFieldKey,
                            validator: (value) => Validators.confirmPasswordValidator(value, _pass_controller.text.trim()),
                            title: "Confirm Password",
                            isobsecure: true,
                            controller: _confirm_pass_controller),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.0,
                              child: Checkbox(
                                value: true,
                                onChanged: (bool? value) {},
                                activeColor: AppColors.primary_orange_color,
                              ),
                            ),
                            const Text(
                              'I agree to the Terms & Conditions',
                              style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.04),
                        registerState.when(
                          data: (_) {
                            return button_Primary(
                              title: "Sign Up",
                              onPressed: () async {
                                final isNameValid = _nameFieldKey.currentState?.validate() ?? false;
                                final isEmailValid = _emailFieldKey.currentState?.validate() ?? false;
                                final isPasswordValid = _passwordFieldKey.currentState?.validate() ?? false;
                                final isConfirmPasswordValid = _confirmpasswordFieldKey.currentState?.validate() ?? false;

                                if (isEmailValid && isNameValid && isPasswordValid && isConfirmPasswordValid) {
                                  final success = await ref.read(authProvider.notifier).register(ref, context, _name_controller.text.trim(),
                                      _email_controller.text.trim(), _confirm_pass_controller.text.trim());

                                  if (success) {
                                    _name_controller.clear();
                                    _email_controller.clear();
                                    _pass_controller.clear();
                                    _confirm_pass_controller.clear();
                                  }
                                }

                                // context.pushNamed(routeNames.verification);
                              },
                            );
                          },
                          loading: () => const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary_orange_color,
                          )),
                          // Show loader while API call is in progress
                          error: (err, _) => Text('Error: $err'),
                        ),

                        SizedBox(height: screenHeight * 0.08),
                        Center(
                          child: InkWell(
                            onTap: () {
                              context.go(routeNames.login);
                            },
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: 'Already Registered?',
                                  style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' Login here.',
                                  style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          ),
                        )
                        // OTP field
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
