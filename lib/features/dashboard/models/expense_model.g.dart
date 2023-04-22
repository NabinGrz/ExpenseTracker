// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseDataModel _$$_ExpenseDataModelFromJson(Map<String, dynamic> json) =>
    _$_ExpenseDataModel(
      expense_categories: json['expense_categories'] as String,
      amount: json['amount'] as String,
      expense_name: json['expense_name'] as String,
      created_at: json['created_at'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_ExpenseDataModelToJson(_$_ExpenseDataModel instance) =>
    <String, dynamic>{
      'expense_categories': instance.expense_categories,
      'amount': instance.amount,
      'expense_name': instance.expense_name,
      'created_at': instance.created_at,
      'id': instance.id,
    };
