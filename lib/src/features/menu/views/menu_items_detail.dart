import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:biteblitz/src/features/menu/views/widgets/menu_widgets.dart';
import 'package:biteblitz/src/models/menuItem%20Model.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/views/widgets/dailog.dart';
import '../../../utils/router.dart';

class item_DetailsPage extends StatefulWidget {
  final MenuItemModel item;

  item_DetailsPage({required this.item});

  @override
  State<item_DetailsPage> createState() => _item_DetailsPageState();
}

class _item_DetailsPageState extends State<item_DetailsPage> {
  // Utility method to calculate the percentage amount of a given price
  // String calculatePercentageAmount(double price, double percentage) {
  //
  //   double amount =  (price * percentage) / 100;
  //   return amount.toStringAsFixed(2);
  // }

  // late String cgstAmount;
  // late String sgstAmount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // cgstAmount = calculatePercentageAmount(widget.item.pricingDetails.price, widget.item.pricingDetails.cgstPercentage);
    //
    // sgstAmount = calculatePercentageAmount(widget.item.pricingDetails.price, widget.item.pricingDetails.sgstPercentage);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: appbar(
          title: widget.item.name,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => CustomDelete());
              },
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.primary_orange_color,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHieght * 0.22,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  image: DecorationImage(
                    image: AssetImage(widget.item.imageUrl), // Replace with actual path
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              SizedBox(height: screenHieght * 0.04),
              CustomCard(item: widget.item,),
              SizedBox(height: screenHieght * 0.04),

              // Pricing Details
              totalPriceCard(item: widget.item),
            ],
          ),
        ),
      ),
    );
  }

// Pricing Details Section
}

class CustomCard extends StatelessWidget {
  final MenuItemModel item;
  CustomCard({required this.item});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        ClipPath(
          clipper: BottomRightCurveClipper(),
          child: Container(
            padding: EdgeInsets.fromLTRB(screenHieght*0.02,screenHieght*0.02,screenHieght*0.06,screenHieght*0.02,),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black.withOpacity(0.4),
                //   spreadRadius: 0,
                //   blurRadius: 4,
                // ),
              ],
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary_orange_color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primary_orange_color,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: (){
                context.pushNamed(routeNames.addNew_Item_in_Menu,extra:  item);

              },
              child: const Icon(
                Icons.mode_edit_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomRightCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);

    path.lineTo(size.width - 130, size.height);
    path.quadraticBezierTo(
        size.width - 100, size.height, size.width - 100, size.height - 15);

    path.lineTo(size.width - 100, size.height - 17);

    path.quadraticBezierTo(
        size.width - 100, size.height - 37, size.width - 70, size.height - 37);

    path.lineTo(size.width - 20, size.height - 37);
    path.quadraticBezierTo(
        size.width, size.height - 40, size.width, size.height - 55);

    path.lineTo(size.width, 0);

    path.close();
    return path;}
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
