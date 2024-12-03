import 'package:biteblitz/src/features/orders/views/widgets/order_cards.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

import '../../../res/strings.dart';
class order_Status_screen extends StatefulWidget {
  const order_Status_screen({
    super.key,
  });

  @override
  State<order_Status_screen> createState() => have_orders_screenState();
}

class have_orders_screenState extends State<order_Status_screen> {
  int selectedChipIndex = 0; // Tracks the selected chip index, -1 means none selected

// List of options with labels and dynamic numbers
  final List<Map<String, dynamic>> options = [
    {'label': 'Preparing', 'count': 2},
    {'label': 'Ready', 'count': 0},
    {'label': 'Picked-Up', 'count': 2},
  ];

  // void updateCounts(Map<String, int> newCounts) {
  //   setState(() {
  //     options[0]['count'] = newCounts['Preparing'];
  //     options[1]['count'] = newCounts['Ready'];
  //     options[2]['count'] = newCounts['Picked-Up'];
  //   });
  // }

  // Sample content for each toggle
  final List<Widget> _contentWidgets = [
    const preparingOrderWidget(),
    const Center(child: Text('Ready Content', style: TextStyle(fontSize: 24))),
    const pickedUp_OrderWidget()
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: Row(
                children: List<Widget>.generate(
                  options.length,
                      (int index) {
                    return Container(
                      margin: EdgeInsets.only(right: screenHeight * 0.02),
                      child: FilterChip(
                        backgroundColor: Colors.white,
                        label: Text(
                          // Show the label with the dynamic number
                          '${options[index]['label']} (${options[index]['count']})',
                        ),
                        labelStyle: TextStyle(color: selectedChipIndex == index ? Colors.white : Colors.black),
                        selected: selectedChipIndex == index,
                        showCheckmark: false,
                        selectedColor: AppColors.primary_orange_color,
                        // Customize the selected chip color
                        onSelected: (bool selected) {
                          setState(() {
                            // Update the selected chip index, ensuring only one is selected
                            selectedChipIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          // SizedBox(
          //   height: screenHeight * 0.02,
          // ),
          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              child: _contentWidgets[selectedChipIndex], // Display selected content
            ),
          ),
        ],
      ),
    );
  }
}

class preparingOrderWidget extends StatelessWidget {
  const preparingOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Column(
      children: [
        if (ordersList.isNotEmpty) ...[
          ...ordersList.map((item) =>
              preparingOrder_card(
                order: item,
              )),
        ],
      ],
    );
  }
}

class pickedUp_OrderWidget extends StatelessWidget {
  const pickedUp_OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Column(
      children: [
        if (ordersList.isNotEmpty) ...[
          ...ordersList.map((item) =>
              pickedUP_Order_card(
                order: item,
              )),
        ],
      ],
    );
  }
}
