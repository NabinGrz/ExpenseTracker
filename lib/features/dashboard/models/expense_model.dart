import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseDataModel with _$ExpenseDataModel {
  const factory ExpenseDataModel({
    required String expense_categories,
    required String amount,
    required String expense_name,
    required String created_at,
    String? id,
  }) = _ExpenseDataModel;

  factory ExpenseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataModelFromJson(json);
}
