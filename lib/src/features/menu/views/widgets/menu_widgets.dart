// Reusable Row for Pricing Details
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/views/widgets/shadow_card.dart';
import '../../../../models/menuItem Model.dart';
import '../../../../res/colors.dart';
import '../../../../utils/router.dart';

class buildMenuItem extends StatefulWidget {
  MenuItemModel menu_item;

  buildMenuItem({required this.menu_item});


  @override
  State<buildMenuItem> createState() => _buildMenuItemState();
}

class _buildMenuItemState extends State<buildMenuItem> {
  bool _item_enabled = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02, vertical: screenHeight * 0.01),
      child: shadowContainer(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.menu_item.imageUrl,
                width: screenHeight * 0.10,
                height: screenHeight * 0.10,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: screenHeight * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.menu_item.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                        ),
                      ),
                      SizedBox(
                        width: 52,
                        height: 38,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: _item_enabled,
                            onChanged: (bool value) {
                              setState(() {
                                _item_enabled = value;
                              });
                            },
                            activeColor: Colors.white,
                            // Thumb color when active
                            activeTrackColor: AppColors.primary_orange_color,
                            // Track color when active
                            inactiveThumbColor: Colors.white70,
                            // Thumb color when inactive
                            inactiveTrackColor: Colors.redAccent.shade100, // Track color when inactive
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${widget.menu_item.pricingDetails.price.toString()}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(routeNames.viewMenu_Item, extra: widget.menu_item);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>item_DetailsPage(item:  item)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 6),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          // color: AppColors.primary_orange_color,
                          decoration: BoxDecoration(color: AppColors.primary_orange_color, borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: const Text(
                            'View',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget totalPriceCard({required MenuItemModel item}) {
  return shadowContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pricing Details',
          style: TextStyle(
            color: AppColors.primary_orange_color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        buildPricingRow('Price', '₹${item.pricingDetails.price.toStringAsFixed(2)}'  ),
        buildPricingRow('GST %','${item.pricingDetails.gstPercentage.toString()}%' ),
        buildPricingRow('CGST','${item.pricingDetails.formatted_CGST_Price}(${item.pricingDetails.cgstPercentage.toString()}%)' ),
        buildPricingRow('SGST', '${item.pricingDetails.formatted_SGST_Price}(${item.pricingDetails.sgstPercentage.toString() }%)'),
        buildPricingRow('Price', '₹${item.pricingDetails.otherCharges.toStringAsFixed(2).toString()}'),
        const Divider(
          color: AppColors.divider_color,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),          const SizedBox(height: 10),
        buildPricingRow('Total','₹${item.pricingDetails.total.toStringAsFixed(2)}' , isTotal: true),
      ],
    ),
  );
}
Widget buildPricingRow(String label, String value, {bool isTotal = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary_orange_color : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary_orange_color : Colors.black,
          ),
        ),
      ],
    ),
  );
}
