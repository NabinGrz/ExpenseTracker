import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../core/utils/firebase_query_handler.dart';
import '../features/dashboard/models/expense_categories_model.dart';

class ExpenseDropDown extends StatefulWidget {
  final Function(String) onSuggestionSelected;
  final Function(String) onAddedNewItem;
  final TextEditingController? categoriesController;
  const ExpenseDropDown(
      {super.key,
      required this.onSuggestionSelected,
      required this.onAddedNewItem,
      this.categoriesController});

  @override
  State<ExpenseDropDown> createState() => _ExpenseDropDownState();
}

class _ExpenseDropDownState extends State<ExpenseDropDown> {
  final TextEditingController categoriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.categoriesController ?? categoriesController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: InkWell(
              onTap: () {
                if (widget.categoriesController == null) {
                  categoriesController.clear();
                } else {
                  widget.categoriesController?.clear();
                }
              },
              child: Icon(
                CupertinoIcons.clear,
                size: 15.h,
                color: Colors.red,
              ),
            ),
            hintText: "Select Categories"),
      ),
      onSuggestionSelected: (suggestion) {
        if (widget.categoriesController == null) {
          categoriesController.text = suggestion;
        } else {
          widget.categoriesController?.text = suggestion;
        }
        widget.onSuggestionSelected(suggestion);
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData),
        );
      },
      suggestionsCallback: (pattern) async {
        var collectionData = await FirebaseQueryHelper.getCollectionsAsFuture(
            collectionPath: "expense-categories");
        Map<String, dynamic>? data = {};
        if (collectionData?.docs != null) {
          for (var element in collectionData!.docs) {
            data.addAll(element.data());
          }
        }
        ExpenseCategoriesDataModel expenseCategoriesDataModel =
            ExpenseCategoriesDataModel.fromJson(data);
        return expenseCategoriesDataModel.expense_type.where(
            (element) => element.toLowerCase().contains(pattern.toLowerCase()));
      },
      noItemsFoundBuilder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: m,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("No Item Found!!"),
            ),
            TextButton(
                onPressed: () {
                  widget.onAddedNewItem(categoriesController.text);
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text("Add New")),
          ],
        );
      },
    );
  }
}
