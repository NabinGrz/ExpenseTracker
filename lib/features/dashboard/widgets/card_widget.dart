import 'dart:math' as math;

import 'package:expensetracker/core/constants/app_styles.dart';
import 'package:expensetracker/core/utils/snackbar.dart';
import 'package:expensetracker/global_widgets/elevated_button.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:expensetracker/global_widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/firebase_query_handler.dart';
import '../bloc/expense_bloc.dart';

class CardWidget extends StatelessWidget {
  final Color cardColor;
  final bool isTotalCash;
  final String cardTitle;
  final String cardAmount;
  final BuildContext calendarBloc;
  CardWidget(
      {super.key,
      this.isTotalCash = false,
      required this.cardColor,
      required this.cardTitle,
      required this.cardAmount,
      required this.calendarBloc});
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: cardColor,
      margin: EdgeInsets.only(left: 12.w, bottom: 12.h),
      child: SizedBox(
        height: 160.h,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
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
                  width: 150.w,
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
                      Row(
                        children: [
                          Text(
                            "RS $cardAmount",
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize26,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                updateAmountDialog();
                                // showSnackBar(message: "message");
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))
                        ],
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
          ],
        ),
      ),
    );
  }

  void updateAmountDialog() {
    showDialog(
      context: calendarBloc,
      builder: (_) {
        calendarBloc.read<ExpenseBloc>().updateTotalCashAmount(
            double.parse(cardAmount.isEmpty ? "0" : cardAmount));
        amountController.text = cardAmount;
        return AlertDialog(
          title: Text(isTotalCash ? "Update Total Cash" : "Update In Bank"),
          content: textFormField(
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: "450",
            icon: const Icon(CupertinoIcons.money_dollar),
            suffixIcon: InkWell(
              onTap: () {
                amountController.clear();
              },
              child: Icon(
                CupertinoIcons.clear,
                size: 15.h,
                color: Colors.red,
              ),
            ),
            textInputAction: TextInputAction.done,
            onChanged: (val) {
              isTotalCash
                  ? calendarBloc.read<ExpenseBloc>().updateTotalCashAmount(
                      double.parse(val.isEmpty ? "0" : val))
                  : calendarBloc.read<ExpenseBloc>().updateTotalInBankAmount(
                      double.parse(val.isEmpty ? "0" : val));
            },
          ),
          actions: [
            StreamBuilder(
                stream: isTotalCash
                    ? calendarBloc.read<ExpenseBloc>().totalCashStream
                    : calendarBloc.read<ExpenseBloc>().inBankStream,
                builder: (context, snapshot) {
                  return elevatedButton(
                      onPressed: snapshot.data == null
                          ? null
                          : () async {
                              var cash = FirebaseQueryHelper.firebaseFireStore
                                  .collection("total_cash")
                                  .doc("KND5OKuW1fntgtIOyEvT");
                              var amount = isTotalCash
                                  ? {'cash_amount': snapshot.data}
                                  : {'in_bank': snapshot.data};
                              Navigator.pop(context);
                              await cash.update(amount);

                              showSnackBar(message: "Successfully Updated!!");
                            },
                      child: const Text("Update Now"));
                })
          ],
        );
      },
    );
  }
}
