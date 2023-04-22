import 'dart:math' as math;

import 'package:expensetracker/core/constants/app_styles.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final Color cardColor;
  final String cardTitle;
  const CardWidget(
      {super.key, required this.cardColor, required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: cardColor,
      margin: EdgeInsets.only(left: 12.w),
      child: SizedBox(
        height: 160.h,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardTitle,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "RS 23082",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize26,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      sizedBox(height: 50.h),
                      Text(
                        "**** **** **** 7364",
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/icons/masterCard.png",
                    height: 30.h,
                  )
                ],
              ),
            ),
            Positioned(
              top: -50,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    shape: BoxShape.circle),
                height: 150.h,
                width: 150.w,
              ),
            ),
            Positioned(
              bottom: -90,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(20)
                      // shape: BoxShape.circle,
                      ),
                  height: 120.h,
                  width: 120.w,
                ),
              ),
            ),
            Positioned(
              right: -40,
              bottom: -30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    shape: BoxShape.circle),
                height: 90.h,
                width: 90.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
