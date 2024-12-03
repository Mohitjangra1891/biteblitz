import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  // Sample data representing values for each day
  final List<BarData> data = [
    BarData(day: 'SUN', value: 70),
    BarData(day: 'MON', value: 90),
    BarData(day: 'TUE', value: 60),
    BarData(day: 'WED', value: 40),
    BarData(day: 'THU', value: 74),
    BarData(day: 'FRI', value: 35),
    BarData(day: 'SAT', value: 79),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding:  EdgeInsets.only(top: screenHeight*0.02 ,right: screenHeight*0.02 , left: screenHeight*0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: data.map((barData) => BarChart(barData: barData)).toList(),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final BarData barData;

  const BarChart({required this.barData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Bar Container
        Container(
          width: 10,
          height: barData.value, // Adjust height based on the value
          decoration: BoxDecoration(
            color: AppColors.primary_orange_color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 4),
        // Day Label
        Text(
          barData.day,
          style: TextStyle(fontSize: 9, color:AppColors.dark_text_color ,fontWeight: FontWeight.w700 ),
        ),
      ],
    );
  }
}

// Model class to hold bar data
class BarData {
  final String day;
  final double value;

  BarData({required this.day, required this.value});
}

