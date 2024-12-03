import 'dart:convert';

import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/common/views/widgets/text_field_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/repo/restaurant_repo.dart';
import '../../../../common/services/snackBar_service.dart';
import '../../../../common/views/widgets/shadow_card.dart';
import '../../../../res/colors.dart';
import '../../repo/accountTab_repo.dart';

class delete_account_screen extends ConsumerStatefulWidget {
  const delete_account_screen({super.key});

  @override
  ConsumerState<delete_account_screen> createState() => _delete_account_screenState();
}

class _delete_account_screenState extends ConsumerState<delete_account_screen> {
  bool _isLoading = false;

  TextEditingController _pass_controller = TextEditingController();

  Future<void> _delete({required String password}) async {
    if (password.isEmpty) {
      SnackBarService.showSnackBar(context: context, message: "Please enter your password.");
    } else {
      final accountRepo = ref.read(AccountRepoProvider);
      setState(() {
        _isLoading = true;
      });

      try{
        final response = await accountRepo.deleteAccount(password: password);
        final Map<String, dynamic> responseBody = json.decode(response!.body);

        if (response.statusCode == 200 && responseBody['success'] == true) {
          SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
        } else {
          SnackBarService.showSnackBar(context: context, message: "${responseBody['message']}");
        }
      }
      catch(e)
      {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Delete Account',
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
                  const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.  Deleting your account will permanently remove all of your data, including your profile information, order history, and saved preferences.  Please note that this action is irreversible and you will lose access to your account immediately.',
                    style: TextStyle(fontSize: 14, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const Text(
                    'Please note that this action is irreversible and you will lose access to your account immediately.',
                    style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            shadowContainer(
              child: textField_second(
                title: "Enter Password",
                hint: '********',
                controller: _pass_controller,
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
                      _delete(
                        password: _pass_controller.text.trim(),
                      );
                    },
                    title: 'Delete Account',
                  )
          ],
        ),
      ),
    );
  }
}
