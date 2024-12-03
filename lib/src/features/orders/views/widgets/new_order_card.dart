import 'package:biteblitz/src/models/menuItem%20Model.dart';
import 'package:flutter/material.dart';

import '../../../../models/Order_Model.dart';
import '../../../../res/colors.dart';

class new_Order_Card extends StatefulWidget {
  final OrderModel order;
  const new_Order_Card({super.key ,required this.order});

  @override
  State<new_Order_Card> createState() => _new_Order_CardState();
}

class _new_Order_CardState extends State<new_Order_Card> {
  int _minutes = 30;


  void _incrementMinutes() {
    setState(() {
      _minutes += 5;
    });
  }

  void _decrementMinutes() {
    if (_minutes > 5) {
      setState(() {
        _minutes -= 5;
      });
    }
  }
 @override
  Widget build(BuildContext context) {
   double padding = MediaQuery.of(context).size.width * 0.03;

   final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        padding: EdgeInsets.all(16.0),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'ID : ${widget.order.orderId}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      // color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.green_text_color)),
                    child:widget.order.paymentStatus == PaymentStatus.paid ?  const Text(
                       "PAID" ,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.bold,
                      ),
                    ):const Text(
                      "UN-PAID" ,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.green_text_color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Customer Name: ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                  ),
                  Text( '${widget.order.customerName}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
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
              SizedBox(height: screenHeight * 0.015),

              if (widget.order.items.isNotEmpty) ...[
                ...widget.order.items.map((item) =>  Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:  EdgeInsets.all(2),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color:item.dietaryType ==DietaryType.veg  ? AppColors.green_text_color : AppColors.primary_orange_color
                          )
                      ),
                      child:  Icon(
                        Icons.circle,
                        color: item.dietaryType ==DietaryType.veg ?AppColors.green_text_color  : AppColors.primary_orange_color,
                        size: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${item.name} (${item.quantity})',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${item.formattedPrice} x${item.quantity}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.dark_text_color),
                    ),
                  ],
                ),

                ),
              ],

              SizedBox(height: screenHeight * 0.04),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary_orange_color),
                  ),
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
              SizedBox(height: screenHeight * 0.015),
              _buildTimeSelector(),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle Reject action
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        side: const BorderSide(color: AppColors.primary_orange_color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Reject',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary_orange_color),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Accept action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary_orange_color,
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),

      border: Border.all(
          color: Colors.grey
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.max,
        children: [

          Expanded(
            flex: 1,
            child: IconButton(onPressed: _decrementMinutes
                , icon: const Icon(Icons.remove, size: 20 ,color: AppColors.primary_orange_color,)),
          ),
          // SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Container(
              // width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                border: Border.symmetric(
                    vertical: BorderSide(
                        color: Colors.grey
                    ),
                   ),
              ),
              child: Center(
                child: Text(
                  '$_minutes mins',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          // SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: IconButton(onPressed: _incrementMinutes
                , icon: Icon(Icons.add, size: 20 ,color: AppColors.primary_orange_color,)),
          ),
        ],
      ),
    );
  }
}
