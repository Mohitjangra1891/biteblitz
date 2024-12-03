import 'dart:async';

import 'package:biteblitz/src/features/orders/views/widgets/no_orders_screen.dart';
import 'package:biteblitz/src/features/orders/views/widgets/toggle_live_switch.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/router.dart';
import 'orderStatus_Screen.dart';

class orders_screen extends StatefulWidget {
  @override
  State<orders_screen> createState() => _orders_screen_State();
}

class _orders_screen_State extends State<orders_screen> {
  bool have_orders = false;

  @override
  void initState() {
    super.initState();

    // Show bottom sheet after 5 seconds
    // Future.delayed(Duration(seconds: 15), () {
    //   _showBottomSheet(context);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: toggle_live_switch(
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Icon(Icons.search_rounded),
          )
        ],
      ),
      body: have_orders ? order_Status_screen() : no_orders_screen(),
    );
  }

  // Bottom sheet content
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context.pushNamed(routeNames.newOrder);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => new_order_Screen()),
            // );
          },
          child: Container(
            height: 180,
            color: AppColors.primary_orange_color,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.swipe_up,
                      color: Colors.white,
                    ),
                    Text(
                      '1 new Order Recieved',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

