import 'package:biteblitz/src/common/providers/common_providers.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class no_orders_screen extends ConsumerWidget {
  const no_orders_screen({
    super.key,
  });

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final isLive = ref.watch(liveStatusProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: isLive
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
            child: Image.asset(
              AppImages.online_bg,
              height: screenHeight * 0.25,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          const Text(
            'You are Online',
            style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
          ),
          const Text(
            'Waiting for new orders',
            style: TextStyle(fontSize: 12, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
            child: Image.asset(
              AppImages.offline_bg,
              height: screenHeight * 0.25,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          const Text(
            'You are Currently Offline',
            style: TextStyle(fontSize: 16, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
          ),
          Text(
            'Orders are not being accepted',
            style: TextStyle(fontSize: 12, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
