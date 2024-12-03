import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';

import '../../../../models/Order_Model.dart';
import '../../../../models/menuItem Model.dart';

class preparingOrder_card extends StatefulWidget {
  final OrderModel order;

  const preparingOrder_card({super.key, required this.order});

  @override
  State<preparingOrder_card> createState() => _preparingOrder_cardState();
}

class _preparingOrder_cardState extends State<preparingOrder_card> {
  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.02;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        // Adjust the Column size to take only the needed space
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ID : ${widget.order.orderId}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        // color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.deepPurpleAccent)),
                      child: const Text(
                        "PREPARING",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.print_outlined,
                        color: AppColors.primary_orange_color,
                      ))
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: screenHeight * 0.015),
              if (widget.order.items.isNotEmpty) ...[
                ...widget.order.items.map(
                      (item) => Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border:
                            Border.all(color: item.dietaryType == DietaryType.veg ? AppColors.green_text_color : Colors.red)),
                        child: Icon(
                          Icons.circle,
                          color: item.dietaryType == DietaryType.veg ? AppColors.green_text_color : Colors.red,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${item.name} (${item.quantity})',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${item.formattedPrice} x${item.quantity}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      // color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.green_text_color)),
                    child: widget.order.paymentStatus == PaymentStatus.paid
                        ? const Text(
                      "PAID",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : const Text(
                      "UN-PAID",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.order.formattedTotalPrice}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              // SizedBox(height: screenHeight * 0.01),
              Row(

                children: [
                  Image.asset(
                    AppImages.userImage,
                    height: screenHeight * 0.06,
                    width: screenHeight * 0.06,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: screenHeight * 0.015),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order.customerName,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.dark_text_color),
                      ),
                      const Text(
                        "10th order",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: AppColors.primary_orange_color),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary_orange_color,
                    ),
                  )
                ],
              ),
              // SizedBox(height: screenHeight * 0.01),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: screenHeight * 0.015),
              const Text(
                'Searching for riders nearby, Assigning soon...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}






///
class pickedUP_Order_card extends StatefulWidget {
  final OrderModel order;

  const pickedUP_Order_card({super.key, required this.order});

  @override
  State<pickedUP_Order_card> createState() => _pickedUP_Order_cardState();
}

class _pickedUP_Order_cardState extends State<pickedUP_Order_card> {
  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.02;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        // Adjust the Column size to take only the needed space
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ID : ${widget.order.orderId}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        // color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.deepPurpleAccent)),
                      child: const Text(
                        "PICKED UP",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.print_outlined,
                        color: AppColors.primary_orange_color,
                      ))
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: screenHeight * 0.015),
              if (widget.order.items.isNotEmpty) ...[
                ...widget.order.items.map(
                      (item) => Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border:
                            Border.all(color: item.dietaryType == DietaryType.veg ? AppColors.green_text_color : Colors.red)),
                        child: Icon(
                          Icons.circle,
                          color: item.dietaryType == DietaryType.veg ? AppColors.green_text_color : Colors.red,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${item.name} (${item.quantity})',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${item.formattedPrice} x${item.quantity}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      // color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.green_text_color)),
                    child: widget.order.paymentStatus == PaymentStatus.paid
                        ? const Text(
                      "PAID",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : const Text(
                      "UN-PAID",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.order.formattedTotalPrice}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              // SizedBox(height: screenHeight * 0.01),
              Row(

                children: [
                  Image.asset(
                    AppImages.userImage,
                    height: screenHeight * 0.06,
                    width: screenHeight * 0.06,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: screenHeight * 0.015),

                  const Expanded(
                    child: Text(
                      maxLines: 2,overflow: TextOverflow.ellipsis,
                      "Mukesh Kumar picked up the food",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.dark_text_color),
                    ),
                  ),
                  // Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary_orange_color,
                    ),
                  )
                ],
              ),
              // SizedBox(height: screenHeight * 0.01),
              const Divider(
                color: AppColors.divider_color,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  const Text(
                    'Order was prepared within time',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  Icon(Icons.check_circle_outline_rounded ,color: AppColors.primary_orange_color,)

                ],
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
