// Reusable Container with Shadow
import 'package:flutter/material.dart';

class shadowContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  shadowContainer({required this.child , this.color ,this.padding});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: padding ?? EdgeInsets.all(screenHeight * 0.02),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}
