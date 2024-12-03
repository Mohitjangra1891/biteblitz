import 'package:biteblitz/src/features/analytics/views/widgets/card_item.dart';
import 'package:biteblitz/src/features/analytics/views/widgets/monthly_revenue_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/views/widgets/appBar.dart';
import '../../../res/colors.dart';

class growth_screen extends StatelessWidget {
  const growth_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Growth',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child:  Column(
          children: [
            analytics_item_card(
                title: 'Monthly Revenue', icon: Icons.calendar_month_outlined, bottomWidget: Monthly_Revenue_Chart()),

            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: analytics_item_card(
                    title: '+10 %',
                    subtitle: 'Monthly Growth',
                    icon: Icons.browse_gallery_rounded,
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.02,
                ),
                const Expanded(
                  child: analytics_item_card(
                    title: "+15 %",
                    subtitle: 'ROI',
                    icon: Icons.list_alt_outlined,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: screenHeight * 0.02,
            ),
             analytics_item_card(
              title: '486',
              subtitle: 'New Customer Acquisition',
              icon: Icons.group_add_outlined,

              trailing: Container(
                // margin: EdgeInsets.only(right: 6),
                padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 87, 51, 0.12),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color:AppColors.primary_orange_color ,
                  ),
                ),
                child:  Text(
                  '15.6% ↑',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

