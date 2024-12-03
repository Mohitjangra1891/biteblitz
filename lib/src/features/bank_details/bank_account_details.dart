import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/models/bankData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



import '../../res/colors.dart';
import '../../res/imges.dart';
import '../../res/strings.dart';
import '../../utils/router.dart';
import 'controller/bankAccountController.dart';

// Provider to manage the loading state
final isLoadingProvider = StateProvider<bool>((ref) => false);

class bank_account_details_screen extends ConsumerStatefulWidget {
  const bank_account_details_screen({super.key});

  @override
  ConsumerState<bank_account_details_screen> createState() => _bank_account_details_screenState();
}

class _bank_account_details_screenState extends ConsumerState<bank_account_details_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bankAccountsProvider.notifier).fetchAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final banksList = ref.watch(bankAccountsProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isdefault = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Bank Details',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (banksList.isNotEmpty) ...[
                ...banksList.map((bank) => _bank_card(bank, screenHeight, context)),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                    onPressed: () {
                      context.pushNamed(routeNames.addNew_Bank);

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_bank_screen()));
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.primary_orange_color,
                          size: 16,
                        ),
                        Text(
                          ' Add Bank Account',
                          style: TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bank_card(BankDataModel bank, screenHeight, BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(routeNames.bank_Acc_Info, extra: bank);

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>single_account_detail_screen(bankName: bank_name)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        child: shadowContainer(
            child: Row(
          children: [
            Image.asset(
              AppImages.hdfc_bank,
              height: 36,
              width: 36,
            ),
            SizedBox(
              width: screenHeight * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank.bankName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark_text_color,
                    ),
                  ),
                  // SizedBox(height: screenHeight*0.005),

                  bank.isdefault!
                      ? const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 12,
                              color: Colors.green,
                            ),
                            Text(
                              ' Default Bank to recieve money',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(
              width: screenHeight * 0.01,
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primary_orange_color,
              size: 28,
            ),
          ],
        )),
      ),
    );
  }
}
