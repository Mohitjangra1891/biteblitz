import 'package:biteblitz/src/features/orders/views/widgets/new_order_card.dart';
import 'package:biteblitz/src/res/strings.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class new_order_Screen extends StatefulWidget {
  @override
  _NewOrderSheetState createState() => _NewOrderSheetState();
}

class _NewOrderSheetState extends State<new_order_Screen> {
  bool _isSnackbarVisible = true;

  void _dismissSnackbar() {
    setState(() {
      _isSnackbarVisible = false; // Hides the snackbar
    });
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.03;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),

              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: Offset(1.0, 0.0), // From right (1.0 means fully right)
                  end: Offset(0.0, 0.0), // To normal position (center)
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: _isSnackbarVisible
                  ? Container(
                      key: ValueKey("snackbar"), // Unique key to identify widget
                      color: AppColors.primary_orange_color,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            '1 New Order',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel_outlined, color: Colors.white),
                            onPressed: _dismissSnackbar,
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(), // Empty widget when snackbar is hidden
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // AnimatedSwitcher for smooth transitions
                
                    if (ordersList.isNotEmpty) ...[
                      ...ordersList.map((item) => new_Order_Card(
                            order: item,
                          )),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
