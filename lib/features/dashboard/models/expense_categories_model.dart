import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_categories_model.freezed.dart';
part 'expense_categories_model.g.dart';

@freezed
class ExpenseCategoriesDataModel with _$ExpenseCategoriesDataModel {
  const factory ExpenseCategoriesDataModel({
    required List<String> expense_type,
  }) = _ExpenseCategoriesDataModel;

  factory ExpenseCategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoriesDataModelFromJson(json);
}
