// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseCategoriesDataModel _$$_ExpenseCategoriesDataModelFromJson(
        Map<String, dynamic> json) =>
    _$_ExpenseCategoriesDataModel(
      expense_type: (json['expense_type'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ExpenseCategoriesDataModelToJson(
        _$_ExpenseCategoriesDataModel instance) =>
    <String, dynamic>{
      'expense_type': instance.expense_type,
    };
