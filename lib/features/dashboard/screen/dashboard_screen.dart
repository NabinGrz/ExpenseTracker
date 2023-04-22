import 'package:expensetracker/core/constants/app_styles.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:expensetracker/features/dashboard/widgets/card_widget.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_state.dart';
import '../widgets/add_expense_dialog.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DateTime _selectedDay = DateTime.now();

  final DateTime _focusedDay = DateTime.now();

  List<ExpenseDataModel> todaysExpenseList = [];
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF1C2125),
          centerTitle: false,
          title: const Text(
            "Expense Tracker",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
        ),
        body: BlocConsumer<CalendarBloc, CalendarState>(
          listener: (calendarBloc, state) {
            if (state is CalendarInitialState) {
              //total_cash
              FirebaseQueryHelper.getSingleDocument(
                  collectionPath: "total_cash", docID: "KND5OKuW1fntgtIOyEvT");
            }
          },
          builder: (calendarBloc, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0XFF1C2125),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream:
                                  FirebaseQueryHelper.getSingleDocumentAsStream(
                                      collectionPath: "total_cash",
                                      docID: "KND5OKuW1fntgtIOyEvT"),
                              builder: (context, snapshot) {
                                List<double> amounts = [];
                                if (snapshot.data != null) {
                                  amounts.clear();
                                  snapshot.data?.data()?.forEach((key, value) {
                                    amounts.add(value);
                                  });
                                }
                                return !snapshot.hasData
                                    ? Container()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CardWidget(
                                              cardColor:
                                                  const Color(0xff4a55e2),
                                              cardTitle: "Total Cash",
                                              cardAmount: "${amounts[0]}"),
                                          CardWidget(
                                            cardColor: const Color(0xffd4756b),
                                            cardTitle: "In Bank",
                                            cardAmount: "${amounts[1]}",
                                          ),
                                        ],
                                      );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: StreamBuilder(
                        stream: FirebaseQueryHelper.getCollectionsAsStream(
                            collectionPath: "expenses"),
                        builder: (calendarBloc, snapshot) {
                          if (snapshot.data != null) {
                            todaysExpenseList.clear();
                            for (var element in snapshot.data!.docs) {
                              Map<String, dynamic> finalData = {
                                ...element.data(),
                                'id': element.id
                              };
                              var exp = ExpenseDataModel.fromJson(finalData);
                              if (exp.created_at.toDate().dateFormat("yMd") ==
                                  DateTime.now().dateFormat("yMd")) {
                                todaysExpenseList.add(exp);
                              }
                              totalAmount = todaysExpenseList.length;
                              for (var element in todaysExpenseList) {
                                totalAmount =
                                    totalAmount + int.parse(element.amount);
                              }
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Today's Expense",
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Total: Rs $totalAmount",
                                style: TextStyle(
                                    fontSize: AppFontSize.fontSize12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                              sizedBox(
                                height: 10.h,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: todaysExpenseList.where((v) {
                                  var createdDate =
                                      v.created_at.toDate().dateFormat("yMd");
                                  var currentDay =
                                      DateTime.now().dateFormat("yMd");
                                  return createdDate == currentDay;
                                }).length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    background: Card(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      FirebaseQueryHelper
                                          .deleteDocumentOfCollection(
                                              collectionID: "expenses",
                                              docID:
                                                  todaysExpenseList[index].id ??
                                                      "-1");
                                    },
                                    child: Card(
                                      child: ListTile(
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddExpenseDialog(
                                                isEdit: true,
                                                expenseDataModel:
                                                    todaysExpenseList[index],
                                              );
                                            },
                                          );
                                        },
                                        title: Text(
                                          todaysExpenseList[index].expense_name,
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(todaysExpenseList[index]
                                            .expense_categories),
                                        trailing: Text(
                                          "Rs: ${todaysExpenseList[index].amount}",
                                          style: TextStyle(
                                            fontSize: AppFontSize.fontSize16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AddExpenseDialog();
                },
              );
            },
            label: const Text("Add New Expense")),
      ),
    );
  }
}
