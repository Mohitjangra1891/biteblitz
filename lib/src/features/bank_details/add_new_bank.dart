import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/features/bank_details/widgets/bank_textfield.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';


class add_new_bank_screen extends StatelessWidget {
  const add_new_bank_screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _bankName_controller = TextEditingController();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isdefault = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Select Your Bank',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bankname_textfield(bankName_controller: _bankName_controller),
            SizedBox(height: screenHeight * 0.02,),
            shadowContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Banks',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary_orange_color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children:List.generate(4, (index) {
    return
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                            },
                            splashColor: Colors.white,
                            child: Container(
                              width: 56,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white, // White button
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1), // Slight shadow
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 0), // Shadow position
                                  ),
                                ],
                              ),
                              child: Image.asset(AppImages.hdfc_bank ,height: 40,width: 40,),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          const Text(
                            'HDFC',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.dark_text_color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );

                  }),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
