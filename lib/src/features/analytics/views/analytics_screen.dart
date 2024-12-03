import 'package:biteblitz/src/features/analytics/views/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/router.dart';

class analytics_screen extends StatelessWidget {
  const analytics_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Analytics",
          style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  context.pushNamed(routeNames.insights );

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => insights_screen()));
                },
                child: const analytics_item_card(
                  title: 'Insights',
                  subtitle: insights_des,
                  icon: Icons.analytics_outlined,
                  iconsize: 28,
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            InkWell(
                onTap: () {
                  context.pushNamed(routeNames.growth );
                },
                child: const analytics_item_card(
                  title: 'Growth',
                  subtitle: growth_des,
                  icon: Icons.workspaces_outline,
                  iconsize: 28,
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            InkWell(
              onTap: (){


                context.pushNamed(routeNames.customer_feedback_analysis );

              },
              child: const analytics_item_card(
                title: 'Customer Feedback Analysis',
                subtitle: customer_feedback_des,
                icon: Icons.feedback_outlined,
                iconsize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
