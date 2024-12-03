import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/models/bankData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/services/snackBar_service.dart';
import '../../res/colors.dart';
import '../../res/imges.dart';
import '../../res/strings.dart';
import '../../utils/router.dart';
import 'controller/bankAccountController.dart';

// final isLoadingProvider = StateProvider<bool>((ref) => false);

class single_account_detail_screen extends ConsumerStatefulWidget {
  const single_account_detail_screen({super.key, required this.bank});

  final BankDataModel bank;

  @override
  ConsumerState<single_account_detail_screen> createState() => _single_account_detail_screenState();
}

class _single_account_detail_screenState extends ConsumerState<single_account_detail_screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: appbar(
          title: widget.bank.bankName,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Number Row
                  _buildDetailRow('A/C No.', '${widget.bank.accNumber}', context),
                  SizedBox(height: screenHeight * 0.01),
                  // IFSC Code Row
                  _buildDetailRow('IFSC', '${widget.bank.ifsc}', context),
                  SizedBox(height: screenHeight * 0.01),
                  // Account Type Row
                  _buildDetailRow('Type', widget.bank.bankType?.value ?? "Savings", context),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            shadowContainer(
                child: Row(
              children: [
                const Icon(
                  Icons.food_bank_outlined,
                  color: AppColors.primary_orange_color,
                  size: 28,
                ),
                SizedBox(
                  width: screenHeight * 0.015,
                ),
                const Expanded(
                  child: Text(
                    "Default Bank to receive money",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark_text_color,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.01,
                ),
                widget.bank.isdefault!
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : SizedBox.shrink(),
              ],
            )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                remove_bank_dailog(context, ref, widget.bank.id);
                // showDialog(
                //     context: context, barrierDismissible: false, builder: (BuildContext context) => remove_bank_dailog(context, ref, widget.bank.id));
              },
              child: shadowContainer(
                  child: Row(
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.primary_orange_color,
                    size: 28,
                  ),
                  SizedBox(
                    width: screenHeight * 0.015,
                  ),
                  const Expanded(
                    child: Text(
                      "Remove Account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark_text_color,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenHeight * 0.01,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each detail row
  Widget _buildDetailRow(String title, String value, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        SizedBox(
          width: screenHeight * 0.10,
          child: Text(
            '$title ',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.dark_text_color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Value Text
        Expanded(
          child: Text(
            ":$value",
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.dark_text_color,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void remove_bank_dailog(BuildContext context, WidgetRef ref, String id) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // final isLoading = ref.watch(isLoadingProvider);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          bool isLoading = false;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              elevation: 2.0,
              // backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(screenHeight * 0.03),
                child: isLoading
                    ? SizedBox(
                        height: 120, // Constrain height
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary_orange_color,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cancel_outlined,
                                color: AppColors.primary_orange_color,
                                size: 16,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Text(
                                'Remove Bank Account',
                                style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const Text(
                            "Are you sure you want to remove this Bank Account?",
                            style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                                    side: const BorderSide(
                                      color: AppColors.primary_orange_color,
                                    )),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenHeight * 0.02),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await ref.read(bankAccountsProvider.notifier).deleteAccount(id, context);
                                    Navigator.of(context).pop(); // Close the dialog
                                    Navigator.of(context).pop(); // Go back to the list screen
                                  } catch (e) {
                                    Navigator.of(context).pop(); // Close the dialog

                                    setState(() {
                                      isLoading = false;
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Failed to delete account')),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }

                                  // await deleteAccount(context, ref, id);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary_orange_color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
              ),
            );
          });
        });
  }
}
