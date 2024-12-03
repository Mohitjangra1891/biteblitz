import 'dart:convert';

import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/common/views/widgets/text_field_.dart';
import 'package:biteblitz/src/features/account/repo/accountTab_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/snackBar_service.dart';
import '../../../res/colors.dart';

class contact_us_screen extends ConsumerStatefulWidget {
  const contact_us_screen({super.key});

  @override
  ConsumerState<contact_us_screen> createState() => _contact_us_screenState();
}

class _contact_us_screenState extends ConsumerState<contact_us_screen> {
  bool _isLoading = false;

  // Create a TextEditingController with default text
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _message_controller = TextEditingController();

  Future<void> _sendContactMessage({required String name, required String email, required String message}) async {
    final accountRepo = ref.read(AccountRepoProvider);
    setState(() {
      _isLoading = true;
    });

    final response = await accountRepo.contactUS(name: name, email: email, message: message);
    final Map<String, dynamic> responseBody = json.decode(response!.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {
      SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
      _message_controller.clear();
    } else {
      SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
    }

    setState(() {
      _isLoading = false;
    });
  }

  _onClick({required String name, required String email, required String message}) {
    if (name.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'Name cannot be empty.');
    } else if (email.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'Email cannot be empty.');
    } else if (message.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'Message cannot be empty.');
    } else {
      _sendContactMessage(name: name, email: email, message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Contact Us',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            shadowContainer(
              child: Column(
                children: [
                  const Text(
                    'Have a question or need assistance?\n Please feel free to reach out to us using the form below. We\'ll getback to you as soon as possible.',
                    style: TextStyle(fontSize: 14, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  textField_second(
                    title: "Your Name",
                    controller: _name_controller,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  textField_second(
                    title: "Your Email Address",
                    controller: _email_controller,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your Message',
                        style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Container(
                        height: screenHeight * 0.08,
                        child: TextField(
                          style: const TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w500),
                          controller: _message_controller,
                          decoration: InputDecoration(
                              fillColor: AppColors.field_color,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.field_color),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.field_color),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.field_color),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.field_color),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              hintText: 'Please describe your inquiry or concern here.',
                              hintStyle: const TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
            Spacer(),
            _isLoading
                ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary_orange_color,
                ))
                : button_Primary(
              onPressed: () {
                _onClick(
                    name: _name_controller.text.trim(),
                    email: _email_controller.text.trim(),
                    message: _message_controller.text.trim());
              },
              title: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
