import 'package:expensetracker/core/utils/extensions.dart';
import 'package:expensetracker/core/utils/firebase_query_handler.dart';
import 'package:expensetracker/features/dashboard/models/expense_model.dart';
import 'package:expensetracker/global_widgets/elevated_button.dart';
import 'package:expensetracker/global_widgets/expense_dropdown.dart';
import 'package:expensetracker/global_widgets/sized_box.dart';
import 'package:expensetracker/global_widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/clear_focus.dart';
import '../../add_expense/bloc/add_expense_bloc.dart';
import '../../add_expense/bloc/add_expense_state.dart';

class AddExpenseDialog extends StatelessWidget {
  final bool isEdit;
  final ExpenseDataModel? expenseDataModel;
  AddExpenseDialog({super.key, this.isEdit = false, this.expenseDataModel});

  final TextEditingController categoriesController = TextEditingController();
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedSuggestion = "";
  @override
  Widget build(BuildContext context) {
    return alertDialogWidget(context);
  }

  void assignValues(context) {
    categoriesController.text = expenseDataModel?.expense_categories ?? "";
    context
        .read<AddExpenseBloc>()
        .updateExpenseCategory(categoriesController.text);
    expenseNameController.text = expenseDataModel?.expense_name ?? "";
    context
        .read<AddExpenseBloc>()
        .updateExpenseName(expenseNameController.text);
    amountController.text = expenseDataModel?.amount ?? "";
    context.read<AddExpenseBloc>().updateExpenseAmount(amountController.text);
  }

  Widget alertDialogWidget(BuildContext context) {
    //  FirebaseQueryHelper.addDataToDocument(
    //                 data: isEdit ? categoriesController.text : val,
    //                 collectionID: "expense-categories",
    //                 docID: "fPK1MVnTnNDH6IPLYVkn");
    return AlertDialog(
      title: Text(isEdit ? "Update Expense" : "Add Expense"),
      content: BlocProvider(
        create: (addExpenseBloc) => AddExpenseBloc(),
        child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
          builder: (addExpenseBloc, state) {
            if (isEdit) {
              categoriesController.text =
                  expenseDataModel?.expense_categories ?? "";
              addExpenseBloc
                  .read<AddExpenseBloc>()
                  .updateExpenseCategory(categoriesController.text);
              expenseNameController.text = expenseDataModel?.expense_name ?? "";
              addExpenseBloc
                  .read<AddExpenseBloc>()
                  .updateExpenseName(expenseNameController.text);
              amountController.text = expenseDataModel?.amount ?? "";
              addExpenseBloc
                  .read<AddExpenseBloc>()
                  .updateExpenseAmount(amountController.text);
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExpenseDropDown(
                  categoriesController: isEdit ? categoriesController : null,
                  onSuggestionSelected: (suggestion) {
                    selectedSuggestion = suggestion;
                    addExpenseBloc
                        .read<AddExpenseBloc>()
                        .updateExpenseCategory(suggestion);
                  },
                  onAddedNewItem: (val) async {
                    FirebaseQueryHelper.addDataToDocument(
                        data: isEdit ? categoriesController.text : val,
                        collectionID: "expense-categories",
                        docID: "Kqpfa3wfUIBfCQVs8UqG");

                    clearFocus();
                    addExpenseBloc.read<AddExpenseBloc>().updateExpenseCategory(
                        isEdit ? categoriesController.text : val);
                    if (!isEdit) {
                      selectedSuggestion = val;
                    } else {
                      // categoriesController.text = val;
                    }
                  },
                ),
                sizedBox(height: 4),
                textFormField(
                  hintText: "Dairy Milk",
                  icon: const Icon(Icons.wallet),
                  controller: expenseNameController,
                  onChanged: (value) {
                    addExpenseBloc
                        .read<AddExpenseBloc>()
                        .updateExpenseName(value);
                  },
                ),
                sizedBox(height: 4),
                textFormField(
                  hintText: "450",
                  icon: const Icon(CupertinoIcons.money_dollar),
                  textInputAction: TextInputAction.done,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: amountController,
                  onChanged: (value) {
                    addExpenseBloc
                        .read<AddExpenseBloc>()
                        .updateExpenseAmount(value);
                  },
                ),
                sizedBox(height: 10),
                StreamBuilder<ExpenseDataModel?>(
                    stream: addExpenseBloc.read<AddExpenseBloc>().expenseData,
                    builder: (addExpenseBloc, snapshot) {
                      return elevatedButton(
                          onPressed: snapshot.data == null
                              ? null
                              : () async {
                                  if (isEdit) {
                                    var updatedData = {
                                      'expense_categories':
                                          categoriesController.text,
                                      'expense_name':
                                          expenseNameController.text,
                                      'amount': amountController.text,
                                      'created_at': DateTime.now().toString()
                                    };
                                    updatedData;
                                    FirebaseQueryHelper
                                        .updateDocumentOfCollection(
                                            docID: expenseDataModel?.id ?? "-1",
                                            collectionID: "expenses",
                                            data: updatedData);
                                    Navigator.pop(context);
                                  } else {
                                    var submitData = {
                                      'expense_categories': selectedSuggestion,
                                      'expense_name':
                                          expenseNameController.text,
                                      'amount': amountController.text,
                                      'created_at': DateTime.now().dateFormat(
                                          "yyyy-MM-dd 00:00:00.00000")
                                    };
                                    submitData;
                                    FirebaseQueryHelper.addDocumentToCollection(
                                        data: submitData,
                                        collectionID: "expenses");

                                    //=========================
                                    var data = await FirebaseQueryHelper
                                        .getSingleDocument(
                                            collectionPath: "total_cash",
                                            docID: "KND5OKuW1fntgtIOyEvT");
                                    var amount =
                                        data?.data() as Map<String, dynamic>;
                                    double cashAmount = amount['cash_amount'];
                                    cashAmount;
                                    var cash = FirebaseQueryHelper
                                        .firebaseFireStore
                                        .collection("total_cash")
                                        .doc("KND5OKuW1fntgtIOyEvT");
                                    var newAmount = {
                                      'cash_amount': cashAmount -
                                          double.parse(amountController.text)
                                    };
                                    Navigator.pop(context);
                                    await cash.update(newAmount);
                                  }
                                },
                          child: Text(isEdit ? "Update" : "Add"));
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
