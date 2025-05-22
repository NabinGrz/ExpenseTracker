import 'package:expensetracker/core/constants/app_styles.dart';
import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/bloc/expense_bloc.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:expensetracker/features/dashboard/widgets/card_widget.dart';
import 'package:expensetracker/features/theme/bloc/theme_bloc.dart'; // Ensure this import is present
import 'package:expensetracker/global_widgets/elevated_button.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Removed AppColors import if AppTheme is handling all colors
// import '../../../core/constants/app_colors.dart'; 
import '../../../global_widgets/category_image_card.dart';
import '../../../global_widgets/no_expense_found_widget.dart';
import '../bloc/expense_state.dart';
import '../widgets/add_expense_dialog.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  List<ExpenseDataModel> todaysTopSpendingList = [];
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(), // This is for expense, ThemeBloc is provided higher up
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor will be set by AppTheme's appBarTheme
          centerTitle: false,
          title: const Text(
            "Expense Tracker",
            // style will be set by AppTheme's appBarTheme
          ),
          elevation: 0,
        ),
        body: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (calendarBloc, state) {
            if (state is ExpenseInitialState) {
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
                // Theme Switch ListTile
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return ListTile(
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                      ),
                      trailing: Switch(
                        value: themeState.isDarkMode,
                        onChanged: (newValue) {
                          context.read<ThemeBloc>().add(ThemeChanged(isDarkMode: newValue));
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                        inactiveThumbColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                    );
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // Use a theme-aware color, e.g., surface or a color from appBarTheme
                        color: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor, // Theme-aware
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
                                          CardWidget( // Card colors are specific, might need theme update later
                                              calendarBloc: calendarBloc,
                                              isTotalCash: true,
                                              cardColor:
                                                  const Color(0xff4a55e2),
                                              cardTitle: "Total Cash",
                                              cardAmount: "${amounts[0]}"),
                                          CardWidget(
                                            calendarBloc: calendarBloc,
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
                            getTodaysTopSpendingsAndGroup(snapshot.data);
                          }
                          return todaysTopSpendingList.isEmpty
                              ? noExpenseFoundWidget(false)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedBox(
                                      height: 20.h,
                                    ),
                                    Text("Top Spending's Today",
                                        style: Theme.of(context) // Text color will be from theme
                                            .textTheme
                                            .displayMedium 
                                            ?.copyWith(
                                              fontSize: AppFontSize.fontSize20,
                                            )),
                                    sizedBox(
                                      height: 8.h,
                                    ),
                                    listViewWidgetOfTopSpendings(),
                                    sizedBox(
                                      height: 10.h,
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
      ),
    );
  }

  void getTodaysTopSpendingsAndGroup(data) {
    totalAmount = 0;
    todaysTopSpendingList.clear();
    for (var element in data!.docs) {
      Map<String, dynamic> finalData = {...element.data(), 'id': element.id};
      var exp = ExpenseDataModel.fromJson(finalData);
      if (exp.created_at.toDate().dateFormat("yMd") ==
              DateTime.now().dateFormat("yMd") &&
          double.parse(exp.amount) >= 500) {
        todaysTopSpendingList.add(exp);
        totalAmount = totalAmount + int.parse(exp.amount);
      }
    }
  }

  void onDissmissed({required BuildContext context, required int index}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Do you want to delete?\nNote: This can't be undone.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: AppFontSize.fontSize14),
              )
            ],
          ),
          actions: [
            elevatedButton(
                onPressed: () {
                  FirebaseQueryHelper.deleteDocumentOfCollection(
                      collectionID: "expenses",
                      docID: todaysTopSpendingList[index].id ?? "-1");
                  Navigator.pop(context);
                },
                child: const Text("Yes Sure!!")),
            elevatedButton(
                backgroundColor: Colors.red, // Consider theming this color
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"))
          ],
        );
      },
    );
  }

  Widget listViewWidgetOfTopSpendings() {
    // Need BuildContext for Theme.of(context)
    return Builder(builder: (context) { // Added Builder for context
      List<ExpenseDataModel> filteredTodaysTopSpendingsList =
          todaysTopSpendingList.where((v) {
        var createdDate = v.created_at.toDate().dateFormat("yMd");
        var currentDay = DateTime.now().dateFormat("yMd");

        return (createdDate == currentDay && double.parse(v.amount) >= 500);
      }).toList();
      Map<String, List<ExpenseDataModel>> groupedTopExpenses =
          filteredTodaysTopSpendingsList.groupBy((val) => val.expense_categories);

      return ListView.separated(
        separatorBuilder: (context, index) {
          return sizedBox(height: 4.h);
        },
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: groupedTopExpenses.length,
        itemBuilder: (context, index) {
          final expenseCategoryName =
              groupedTopExpenses.keys.map((e) => e).toList();
          final expensesList = groupedTopExpenses.values.map((e) => e).toList();
          expensesList[index].sort(
              (a, b) => double.parse(b.amount).compareTo(double.parse(a.amount)));
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  width: 2.w,
                  // Use theme-aware border color
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expenseCategoryName[index].toString(),
                      style: Theme.of(context) // Text color from theme
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.primary), // Explicitly using primary
                    ),
                    Text(
                      "-Rs: ${expensesList[index].map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary, // Explicitly using primary
                          ),
                    ),
                  ],
                ),
                sizedBox(height: 4.h),
                Divider(
                  height: 8.h,
                  thickness: 1.5.h,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2), // Theme-aware
                ),
                Wrap(
                  spacing: 0,
                  children: expensesList[index]
                      .map((val) => ListTile(
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.zero,
                            leading: categoryImageCard(
                              categoryName: val.expense_categories,
                            ),
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddExpenseDialog(
                                    isEdit: true,
                                    expenseDataModel: val,
                                  );
                                },
                              );
                            },
                            title: Text(val.expense_name,
                                style: Theme.of(context).textTheme.displaySmall), // Text color from theme
                            subtitle: Text(val.expense_categories,
                                style: Theme.of(context) // Text color from theme (secondary)
                                    .textTheme
                                    .titleMedium 
                                    ),
                            trailing: Text(
                              "Rs: ${val.amount}",
                              style: TextStyle( // Specific color, consider theming
                                fontSize: AppFontSize.fontSize16,
                                color: const Color(0xff3cb980), 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          );
        },
      );
    });
  }
}
