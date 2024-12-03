import 'dart:convert';

import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/features/account/repo/accountTab_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/snackBar_service.dart';
import '../../../res/colors.dart';

class feedback_screen extends ConsumerStatefulWidget {
  const feedback_screen({super.key});

  @override
  ConsumerState<feedback_screen> createState() => _feedback_screenState();
}

class _feedback_screenState extends ConsumerState<feedback_screen> {
  bool _isLoading = false;
  TextEditingController _message_controller = TextEditingController();

  Future<void> _addFeedback({required String message}) async {
    if (message.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: "Please enter your Message.");
    } else {
      final accountRepo = ref.read(AccountRepoProvider);
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await accountRepo.sendFeedBack(message: message);
        final Map<String, dynamic> responseBody = json.decode(response!.body);

        if (response.statusCode == 200 && responseBody['success'] == true) {
          SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
          _message_controller.clear();
        } else {
          SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
        }
      } catch (e) {
        print("exception-- $e");
        setState(() {
          _isLoading = false;
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController with default text


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Feedback',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            shadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'We value your feedback!',
                    style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  const Text(
                    'Please let us know how we can improve our app by providing your suggestions, comments, or any issues you encountered.',
                    style: TextStyle(fontSize: 14, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.08,
                    child: TextField(
                      // expands: true,
                      // maxLines: 6,
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
                      ),
                    ),
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
                      _addFeedback(
                        message: _message_controller.text.trim(),
                      );
                    },
                    title: 'Submit',
                  )
          ],
        ),
      ),
    );
  }
}
