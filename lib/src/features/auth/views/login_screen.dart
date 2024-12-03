import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:biteblitz/src/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/views/widgets/text_field_.dart';
import '../../../utils/validators.dart';
import '../controllers/auth_controller.dart';

class login_screen extends ConsumerStatefulWidget {
  const login_screen({super.key});

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends ConsumerState<login_screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  TextEditingController _email_controller = TextEditingController(text: "sampe@examle.com");
  TextEditingController _pass_controller = TextEditingController(text: "mohit1891");

// Declare the GlobalKeys in your screen (e.g., LoginScreen)
  final GlobalKey<textField_widgetState> _emailFieldKey = GlobalKey<textField_widgetState>();
  final GlobalKey<textField_widgetState> _passwordFieldKey = GlobalKey<textField_widgetState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginStateProvider);

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back!',
                      style: TextStyle(fontSize: 36, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                    ),
                    // SizedBox(height: screenHeight * 0.02),
                    const Text(
                      'Login to manage your restaurant',
                      style: TextStyle(fontSize: 16, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: Container(
                        width: screenHeight * 0.88,
                        height: screenHeight * 0.30,
                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.06),
                        child: Image.asset(
                          AppImages.login_bg,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    textField_widget(
                      key: _emailFieldKey,
                      title: "Email Address",
                      controller: _email_controller,
                      validator: (value) => Validators.email(value),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    textField_widget(
                      key: _passwordFieldKey,
                      title: "Password",
                      isobsecure: true,
                      controller: _pass_controller,
                      validator: (value) => Validators.validatePassword(value),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (bool? value) {},
                              activeColor: AppColors.primary_orange_color,
                            ),
                            const Text(
                              'Keep me signed in',
                              style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    authState.when(
                      data: (_) {
                        return button_Primary(
                          title: "Login",
                          onPressed: () async {
                            final isEmailValid = _emailFieldKey.currentState?.validate() ?? false;
                            final isPasswordValid = _passwordFieldKey.currentState?.validate() ?? false;

                            if (isEmailValid && isPasswordValid) {
                              await ref.read(authProvider.notifier).login(ref, context, _email_controller.text.trim(), _pass_controller.text.trim());
                             }
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
                          context.pushNamed(routeNames.registration);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>register_screen()));
                        },
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'Not Registered yet?',
                              style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: ' Register here.',
                              style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                            ),
                          ]),
                        ),
                      ),
                    )
                    // OTP field
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
