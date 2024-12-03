import 'package:biteblitz/src/features/analytics/views/widgets/card_item.dart';
import 'package:biteblitz/src/features/analytics/views/widgets/feedback_pie_chart.dart';
import 'package:flutter/material.dart';

import '../../../common/views/widgets/appBar.dart';

class customer_feedback_analysis_screen extends StatelessWidget {
  const customer_feedback_analysis_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Customer Feedback Analysis',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            analytics_item_card(
                title: 'Feedback Breakdown', icon: Icons.feedback_outlined, bottomWidget: FeedbackPieChart()),
          ],
        ),
      ),
    );
  }
}
