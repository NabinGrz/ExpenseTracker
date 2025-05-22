// import 'package:expensetracker/features/add_expense/bloc/add_expense_state.dart';
// import 'package:expensetracker/global_widgets/elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../global_widgets/expense_dropdown.dart';
// import '../../../global_widgets/sized_box.dart';
// import '../../../global_widgets/text_form_field.dart';
// import '../bloc/add_expense_bloc.dart';
// import '../bloc/add_expense_event.dart';

// class AddExpenseScreen extends StatefulWidget {
//   const AddExpenseScreen({super.key});

//   @override
//   State<AddExpenseScreen> createState() => _AddExpenseScreenState();
// }

// class _AddExpenseScreenState extends State<AddExpenseScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (providerContext) => AddExpenseBloc(),
//       child: Scaffold(
//         body: Center(
//           child: BlocConsumer<AddExpenseBloc, AddExpenseState>(
//             listener: (addExpenseBlocContext, state) {
//               if (state is AddExpenseWidgetState) {
//                 // showSnackBar(
//                 //     message: state.toString(), type: SnackBarTypes.Success);
//                 addExpenseBlocContext.read<AddExpenseBloc>().updateWidgetsData({
//                   'expenseNameController': TextEditingController(),
//                   'amountController': TextEditingController(),
//                   'expenseCategoryController': TextEditingController()
//                 });
//               }
//             },
//             builder: (addExpenseBlocContext, state) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   StreamBuilder<List<Map<String, dynamic>>>(
//                       stream: addExpenseBlocContext
//                           .read<AddExpenseBloc>()
//                           .widgetDataListStream,
//                       builder: (_, snapshot) {
//                         // return Text("${snapshot.data?.length}");
//                         return snapshot.data == null
//                             ? Container()
//                             : Expanded(
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: snapshot.data?.length,
//                                   itemBuilder: (context, index) {
//                                     return Wrap(
//                                       children: [
//                                         StreamBuilder(
//                                             stream: addExpenseBlocContext
//                                                 .read<AddExpenseBloc>()
//                                                 .expenseCategoryListStream,
//                                             builder: (context, snapshot) {
//                                               return ExpenseDropDown(
//                                                 // categoriesController:
//                                                 //     snapshot.data?[index],
//                                                 onSuggestionSelected:
//                                                     (suggestion) {
//                                                   snapshot.data?[index].text =
//                                                       suggestion;
//                                                   //                                   'expenseNameController': "Food",
//                                                   // 'amount': 2,
//                                                   // 'expenseCategoryController': TextEditingController()
//                                                 },
//                                               );
//                                             }),
//                                         // sizedBox(
//                                         //     height: 4,
//                                         //     child: Text(index.toString())),
//                                         StreamBuilder(
//                                             stream: addExpenseBlocContext
//                                                 .read<AddExpenseBloc>()
//                                                 .expenseNameListStream,
//                                             builder: (context, snapshot) {
//                                               return textFormField(
//                                                 icon: const Icon(Icons.abc),
//                                                 controller:
//                                                     snapshot.data?[index],
//                                                 onChanged: (value) {},
//                                               );
//                                             }),
//                                         // sizedBox(
//                                         //     height: 4,
//                                         //     child: Text(index.toString())),
//                                         StreamBuilder(
//                                             stream: addExpenseBlocContext
//                                                 .read<AddExpenseBloc>()
//                                                 .amountListStream,
//                                             builder: (context, snapshot) {
//                                               return textFormField(
//                                                 icon: const Icon(
//                                                     Icons.money_rounded),
//                                                 textInputAction:
//                                                     TextInputAction.done,
//                                                 keyboardType:
//                                                     const TextInputType
//                                                             .numberWithOptions(
//                                                         decimal: true),
//                                                 controller:
//                                                     snapshot.data?[index],
//                                                 onChanged: (value) {},
//                                               );
//                                             }),
//                                         sizedBox(height: 4),
//                                       ],
//                                     );
//                                     return testWidget(
//                                         data: snapshot.data ?? [],
//                                         index: index);
//                                   },
//                                 ),
//                               );
//                       }),
//                   StreamBuilder<List<Map<String, dynamic>>>(
//                       stream: addExpenseBlocContext
//                           .read<AddExpenseBloc>()
//                           .widgetDataListStream,
//                       builder: (context, snapshot) {
//                         return snapshot.data == null
//                             ? Container()
//                             : Container(
//                                 color: Colors.red,
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: snapshot.data?.length,
//                                     itemBuilder: (context, index) {
//                                       return Text(
//                                           "${snapshot.data?[index]['expenseNameController'].text}");
//                                     }),
//                               );
//                       }),
//                   elevatedButton(
//                     onPressed: () {
//                       addExpenseBlocContext
//                           .read<AddExpenseBloc>()
//                           .add(AddExpenseWidgetEvent());
//                     },
//                     child: const Text("Add Expense"),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget testWidget(
//       {required List<Map<String, dynamic>> data, required int index}) {
//     return Wrap(
//       children: [
//         ExpenseDropDown(
//           onSuggestionSelected: (suggestion) {
//             //                                   'expenseNameController': "Food",
//             // 'amount': 2,
//             // 'expenseCategoryController': TextEditingController()
//           },
//         ),
//         Text(index.toString()),
//         // sizedBox(
//         //     height: 4,
//         //     child: Text(index.toString())),
//         textFormField(
//           icon: const Icon(Icons.abc),
//           controller: data[index]['expenseNameController'],
//           onChanged: (value) {},
//         ),
//         Text(index.toString()),
//         // sizedBox(
//         //     height: 4,
//         //     child: Text(index.toString())),
//         textFormField(
//           icon: const Icon(Icons.money_rounded),
//           textInputAction: TextInputAction.done,
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//           controller: data[index]['amountController'],
//           onChanged: (value) {},
//         ),
//         sizedBox(height: 4),
//       ],
//     );
//   }
//   // Widget addMoreWidget(int index) {
//   //   return Row(
//   //     children: [
//   //       ExpenseDropDown(
//   //         onSuggestionSelected: (suggestion) {
//   //           selectedSuggestion = suggestion;
//   //         },
//   //       ),
//   //       sizedBox(height: 4),
//   //       textFormField(
//   //         icon: const Icon(Icons.abc),
//   //         controller: expenseNameController,
//   //         onChanged: (value) {},
//   //       ),
//   //       sizedBox(height: 4),
//   //       textFormField(
//   //         icon: const Icon(Icons.money_rounded),
//   //         textInputAction: TextInputAction.done,
//   //         keyboardType: const TextInputType.numberWithOptions(decimal: true),
//   //         controller: amountController,
//   //         onChanged: (value) {},
//   //       ),
//   //       sizedBox(height: 4),
//   //     ],
//   //   );
//   // }
// }
