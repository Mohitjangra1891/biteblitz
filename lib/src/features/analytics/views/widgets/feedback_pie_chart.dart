

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../res/colors.dart';

class FeedbackPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data for the Pie Chart
    Map<String, double> dataMap = {
      "Positive Feedback": 80,
      "Neutral Feedback": 15,
      "Negative Feedback": 5,
    };

    // Color for each section
    final colorList = <Color>[
      Colors.green,
      Colors.yellow,
      Colors.red,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Pie Chart
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: false, // Disable default legends
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              // Disable values inside pie slices
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          SizedBox(width: 20),
          // Custom Legends
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegendItem('80% - Positive Feedback', Colors.green),
              SizedBox(height: 4),
              _buildLegendItem('15% - Neutral Feedback', Colors.yellow),
              SizedBox(height: 4),
              _buildLegendItem('05% - Negative Feedback', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build custom legends
  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
        ),
      ],
    );
  }
}
