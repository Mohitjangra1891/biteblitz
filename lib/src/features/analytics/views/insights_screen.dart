import 'package:biteblitz/src/features/analytics/views/widgets/card_item.dart';
import 'package:biteblitz/src/features/analytics/views/widgets/weekday_vertical_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/views/widgets/appBar.dart';
import '../../../res/strings.dart';

class insights_screen extends StatelessWidget {
  const insights_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Insights',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: analytics_item_card(
                    title: tota_orders,
                    subtitle: 'Total Orders',
                    icon: Icons.confirmation_num_outlined,
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.02,
                ),
                const Expanded(
                  child: analytics_item_card(
                    title: tota_revenue,
                    subtitle: 'Total Revenue',
                    icon: Icons.currency_rupee,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Expanded(
                  child: analytics_item_card(
                    title: average_order,
                    subtitle: 'Average Order Value',
                    icon: Icons.monitor_heart_outlined,
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.02,
                ),
                const Expanded(
                  child: analytics_item_card(
                    title: average_daily_revenuw,
                    subtitle: 'Avg. Daily Revenue',
                    icon: Icons.calendar_today_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const analytics_item_card(
              title: peak_hours,
              subtitle: 'Peak Hours',
              icon: Icons.hourglass_empty_sharp,
            ), SizedBox(
              height: screenHeight * 0.02,
            ),
             analytics_item_card(
              title: "Monday",
              subtitle: 'Busiest Day',
              icon: Icons.calendar_month_outlined,
              bottomWidget: WeeklyBarChart(),
            ),
          ],
        ),
      ),
    );
  }
}
