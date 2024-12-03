import 'dart:convert';

import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/common/views/widgets/text_field_.dart';
import 'package:biteblitz/src/features/account/repo/accountTab_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/repo/restaurant_repo.dart';
import '../../../../common/services/snackBar_service.dart';
import '../../../../res/colors.dart';

class change_passwod_screen extends ConsumerStatefulWidget {
  const change_passwod_screen({super.key});

  @override
  ConsumerState<change_passwod_screen> createState() => _change_passwod_screenState();
}

class _change_passwod_screenState extends ConsumerState<change_passwod_screen> {
  bool _isLoading = false;
  TextEditingController _current_pass_controller = TextEditingController();
  TextEditingController _new_pass_controller = TextEditingController();
  TextEditingController _confirm_new_pass_controller = TextEditingController();

  Future<void> _updatePassword({required String OldPassword, required String NewPassword}) async {
    final accountRepo = ref.read(AccountRepoProvider);
    setState(() {
      _isLoading = true;
    });

    final response = await accountRepo.changePassword(OldPassword: OldPassword, NewPassword: NewPassword);
    final Map<String, dynamic> responseBody = json.decode(response!.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {
      SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
      _current_pass_controller.clear();
      _new_pass_controller.clear();
      _confirm_new_pass_controller.clear();
    } else {
      SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
    }

    setState(() {
      _isLoading = false;
    });
  }

  _onClick({required String oldPassword, required String newPassword, required String confirmPassword}) {
    if (oldPassword.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'Old password cannot be empty.');
    } else if (newPassword.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'New password cannot be empty.');
    } else if (confirmPassword.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: 'Confirm password cannot be empty.');
    } else if (confirmPassword != newPassword) {
      SnackBarService.showSnackBar(context: context, message: 'Passwords do not match.');
    } else {
      _updatePassword(OldPassword: oldPassword, NewPassword: confirmPassword);
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
          title: 'Change Password',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  textField_second(
                    title: "Current Password",
                    hint: '********',
                    controller: _current_pass_controller,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  textField_second(
                    title: "New Password",
                    hint: '********',
                    controller: _new_pass_controller,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  textField_second(
                    title: "Confirm New Password",
                    hint: '********',
                    controller: _confirm_new_pass_controller,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const Text(
              ' Your password should be at least 8 characters long and include a mix of letters, numbers, and symbols. Avoid using easily guessable information and reusing passwords across different accounts.',
              style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
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
                    oldPassword: _current_pass_controller.text.trim(),
                    newPassword: _new_pass_controller.text.trim(),
                    confirmPassword: _confirm_new_pass_controller.text.trim());
              },
              title: 'Save Changes',
            )
          ],
        ),
      ),
    );
  }
}
