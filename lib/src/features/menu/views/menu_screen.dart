import 'package:biteblitz/src/features/menu/views/widgets/menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../res/colors.dart';
import '../../../res/strings.dart';
import '../../../utils/router.dart';

class menu_screen extends StatefulWidget {
  const menu_screen({super.key});

  @override
  State<menu_screen> createState() => _menu_screenState();
}

class _menu_screenState extends State<menu_screen> {

  @override
  Widget build(BuildContext context) {
    // Dummy Data (can be replaced with actual data)

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Menu Details",
          style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Icon(Icons.search_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: screenWidth * 0.02, bottom: screenWidth * 0.22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Tabs
              _buildCategoryTabs(screenHeight),

              // Recommended Section
              if (recommendedItems.isNotEmpty) ...[
                _buildSectionHeader('Recommended', screenHeight: screenHeight, screenWidth: screenWidth),
                ...recommendedItems.map((item) => buildMenuItem( menu_item: item,)),
              ],

              // Pizzas Section
              if (pizzas.isNotEmpty) ...[
                _buildSectionHeader('Pizzas', screenHeight: screenHeight, screenWidth: screenWidth),
                ...pizzas.map((item) =>buildMenuItem( menu_item: item,)),
              ],

              // Sides Section
              if (sides.isNotEmpty) ...[
                _buildSectionHeader('Sides', screenHeight: screenHeight, screenWidth: screenWidth),
                ...sides.map((item) => buildMenuItem( menu_item: item,)),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(routeNames.addNew_Item_in_Menu);

          // Navigator.push(context, MaterialPageRoute(builder: (context) => add_new_item_screen()));
        },
        label: const Text('Add Item', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary_orange_color,
      ),
    );
  }

  // Category Tabs
  Widget _buildCategoryTabs(double screenHeight) {
    return Row(
      // scrollDirection: Axis.horizontal,
      children: [
        _buildTabButton('Recommended', recommendedItems.length, screenHeight),
        _buildTabButton('Pizzas', pizzas.length, screenHeight),
        _buildTabButton('Sides', sides.length, screenHeight),
      ],
    );
  }

  // Single Tab Button
  Widget _buildTabButton(String title, int count, double screenHeight) {
    return count == 0
        ? SizedBox()
        : Container(
            padding: const EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: AppColors.primary_orange_color,
              ),
            ),
            child: Text(
              '$title($count)',
              style: const TextStyle(color: AppColors.primary_orange_color, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          );
  }

  // Section Header
  Widget _buildSectionHeader(String title, {required double screenWidth, required double screenHeight}) {
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.02),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      width: screenWidth,
      color: AppColors.primary_orange_color.withOpacity(0.12),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary_orange_color,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}
