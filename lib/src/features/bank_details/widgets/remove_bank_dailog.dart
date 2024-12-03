// // Reusable Function to Show Dialog
// import 'dart:convert';
//
// import 'package:biteblitz/src/common/services/snackBar_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../res/colors.dart';
// import '../../../controller/bankAccountController.dart';
// import '../../../repo/bankDetails_repo.dart';
// import '../bank_account_details.dart';
//
// class remove_bank_dailog extends ConsumerWidget {
//   final String id;
//   remove_bank_dailog(this.id);
//
//   @override
//   Widget build(BuildContext context ,WidgetRef ref) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//       ),
//       elevation: 2.0,
//       // backgroundColor: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.all(screenHeight * 0.03),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.cancel_outlined,
//                   color: AppColors.primary_orange_color,
//                   size: 16,
//                 ),
//                 SizedBox(width: screenWidth * 0.02),
//                 const Text(
//                   'Remove Bank Account',
//                   style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             const Text(
//               "Are you sure you want to remove this Bank Account?",
//               style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: OutlinedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
//                       side: const BorderSide(
//                         color: AppColors.primary_orange_color,
//                       )),
//                   child: const Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenHeight * 0.02),
//                 ElevatedButton(
//                   onPressed: () async {
//                     Navigator.pop(context);
//                     await deleteAccount(context, ref ,id);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary_orange_color,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: Text(
//                       'Remove',
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> deleteAccount(BuildContext context, WidgetRef ref ,String id) async {
//   try {
//     ref.read(isLoadingProvider.notifier).state = true;
//
//     // Call the delete API via the notifier
//     await ref.read(bankAccountsProvider.notifier).deleteAccount(id);
//
//     SnackBarService.showSnackBar(context: context, message: "Account deleted successfully");
//
//   } catch (e) {
//     SnackBarService.showSnackBar(context: context, message: "Failed to delete account");
//   } finally {
//     // Hide loader
//     ref.read(isLoadingProvider.notifier).state = false;
//     Navigator.of(context).pop();
//
//   }
// }
