import 'package:expensetracker/core/constants/app_styles.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:expensetracker/features/dashboard/widgets/card_widget.dart';
import 'package:expensetracker/global_widgets/category_image_card.dart';
import 'package:expensetracker/global_widgets/elevated_button.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/cupertino.dart';
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
  // imageToBase64() async {
  //   File imagefile = File("assets/icons/bike.png"); //convert Path to File
  //   Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
  //   String base64string =
  //       base64.encode(imagebytes); //convert bytes to base64 string
  //   print(base64string);
  // }

  @override
  Widget build(BuildContext context) {
    // imageToBase64();
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
                            totalAmount = 0;
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
                                totalAmount =
                                    totalAmount + int.parse(exp.amount);
                              }
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today's Expense",
                                    style: TextStyle(
                                      fontSize: AppFontSize.fontSize18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Rs: $totalAmount",
                                    style: TextStyle(
                                        fontSize: AppFontSize.fontSize12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              sizedBox(
                                height: 10.h,
                              ),
                              todaysExpenseList.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Expenses Yet!!",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: AppFontSize.fontSize16,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: todaysExpenseList.where((v) {
                                        var createdDate = v.created_at
                                            .toDate()
                                            .dateFormat("yMd");
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
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Confirmation"),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Do you want to delete?\nNote: This can't be undone.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: AppFontSize
                                                                .fontSize14),
                                                      )
                                                    ],
                                                  ),
                                                  actions: [
                                                    elevatedButton(
                                                        onPressed: () {
                                                          FirebaseQueryHelper
                                                              .deleteDocumentOfCollection(
                                                                  collectionID:
                                                                      "expenses",
                                                                  docID: todaysExpenseList[
                                                                              index]
                                                                          .id ??
                                                                      "-1");
                                                        },
                                                        child: const Text(
                                                            "Yes Sure!!")),
                                                    elevatedButton(
                                                        backgroundColor:
                                                            Colors.red,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            child: ListTile(
                                              minLeadingWidth: 0,
                                              minVerticalPadding: 0,
                                              leading: categoryImageCard(
                                                categoryName:
                                                    todaysExpenseList[index]
                                                        .expense_categories,
                                              ),
                                              onLongPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AddExpenseDialog(
                                                      isEdit: true,
                                                      expenseDataModel:
                                                          todaysExpenseList[
                                                              index],
                                                    );
                                                  },
                                                );
                                              },
                                              title: Text(
                                                todaysExpenseList[index]
                                                    .expense_name,
                                                style: TextStyle(
                                                  fontSize:
                                                      AppFontSize.fontSize14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  todaysExpenseList[index]
                                                      .expense_categories),
                                              trailing: Text(
                                                "Rs: ${todaysExpenseList[index].amount}",
                                                style: TextStyle(
                                                  fontSize:
                                                      AppFontSize.fontSize16,
                                                  color:
                                                      const Color(0xff3cb980),
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
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AddExpenseDialog();
                },
              );
            },
            child: const Icon(CupertinoIcons.add)),
      ),
    );
  }
}
