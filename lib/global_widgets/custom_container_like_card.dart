import 'package:flutter/material.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double height;
  final double width;
  final double minElevation;
  final double maxElevation;

  const CustomShadowContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    required this.elevation,
    this.minElevation = 0.0,
    this.maxElevation = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    double clampedElevation = elevation.clamp(minElevation, maxElevation);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, clampedElevation / 2),
            blurRadius: clampedElevation,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            offset: Offset(0, clampedElevation / 4),
            blurRadius: clampedElevation / 2,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, clampedElevation / 6),
            blurRadius: clampedElevation / 4,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
