import 'package:biteblitz/src/common/views/widgets/shadow_card.dart';
import 'package:flutter/material.dart';

import '../../../../res/colors.dart';
class analytics_item_card extends StatelessWidget {
  const analytics_item_card({
    super.key, required this.title , this.subtitle ,required this.icon , this.iconsize,this.trailing,this.bottomWidget
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final double? iconsize;
  final Widget? trailing;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double Iconsize=iconsize ?? 22;
    return shadowContainer(child:

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Material(
                color: Color.fromRGBO(255, 87, 51, 0.12),
                child: SizedBox(
                  width: Iconsize*1.8  ,
                  height: Iconsize*1.8,
                  child:   Icon(
                    icon,
                    color: AppColors.primary_orange_color,
                    size: Iconsize,
                  ),),
              ),
            ),
            SizedBox(
              width: screenHeight * 0.015,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary_orange_color,
                    ),
                  ),
                  SizedBox(height: screenHeight*0.005),

                  subtitle != null ?
                  Text(subtitle?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.dark_light_text_color,
                      fontWeight: FontWeight.w400,
                    ),
                  ) : SizedBox.shrink(),
                ],
              ),
            ),

            trailing ?? SizedBox.shrink(),

          ],
        ),

        bottomWidget ?? SizedBox.shrink(),
      ],
    ));
  }
}

