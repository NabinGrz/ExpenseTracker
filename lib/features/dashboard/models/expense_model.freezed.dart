// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseDataModel _$ExpenseDataModelFromJson(Map<String, dynamic> json) {
  return _ExpenseDataModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseDataModel {
  String get expense_categories => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get expense_name => throw _privateConstructorUsedError;
  String get created_at => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseDataModelCopyWith<ExpenseDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseDataModelCopyWith<$Res> {
  factory $ExpenseDataModelCopyWith(
          ExpenseDataModel value, $Res Function(ExpenseDataModel) then) =
      _$ExpenseDataModelCopyWithImpl<$Res, ExpenseDataModel>;
  @useResult
  $Res call(
      {String expense_categories,
      String amount,
      String expense_name,
      String created_at,
      String? id});
}

/// @nodoc
class _$ExpenseDataModelCopyWithImpl<$Res, $Val extends ExpenseDataModel>
    implements $ExpenseDataModelCopyWith<$Res> {
  _$ExpenseDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense_categories = null,
    Object? amount = null,
    Object? expense_name = null,
    Object? created_at = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      expense_categories: null == expense_categories
          ? _value.expense_categories
          : expense_categories // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      expense_name: null == expense_name
          ? _value.expense_name
          : expense_name // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpenseDataModelCopyWith<$Res>
    implements $ExpenseDataModelCopyWith<$Res> {
  factory _$$_ExpenseDataModelCopyWith(
          _$_ExpenseDataModel value, $Res Function(_$_ExpenseDataModel) then) =
      __$$_ExpenseDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String expense_categories,
      String amount,
      String expense_name,
      String created_at,
      String? id});
}

/// @nodoc
class __$$_ExpenseDataModelCopyWithImpl<$Res>
    extends _$ExpenseDataModelCopyWithImpl<$Res, _$_ExpenseDataModel>
    implements _$$_ExpenseDataModelCopyWith<$Res> {
  __$$_ExpenseDataModelCopyWithImpl(
      _$_ExpenseDataModel _value, $Res Function(_$_ExpenseDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense_categories = null,
    Object? amount = null,
    Object? expense_name = null,
    Object? created_at = null,
    Object? id = freezed,
  }) {
    return _then(_$_ExpenseDataModel(
      expense_categories: null == expense_categories
          ? _value.expense_categories
          : expense_categories // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      expense_name: null == expense_name
          ? _value.expense_name
          : expense_name // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpenseDataModel implements _ExpenseDataModel {
  const _$_ExpenseDataModel(
      {required this.expense_categories,
      required this.amount,
      required this.expense_name,
      required this.created_at,
      this.id});

  factory _$_ExpenseDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseDataModelFromJson(json);

  @override
  final String expense_categories;
  @override
  final String amount;
  @override
  final String expense_name;
  @override
  final String created_at;
  @override
  final String? id;

  @override
  String toString() {
    return 'ExpenseDataModel(expense_categories: $expense_categories, amount: $amount, expense_name: $expense_name, created_at: $created_at, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpenseDataModel &&
            (identical(other.expense_categories, expense_categories) ||
                other.expense_categories == expense_categories) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.expense_name, expense_name) ||
                other.expense_name == expense_name) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, expense_categories, amount, expense_name, created_at, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpenseDataModelCopyWith<_$_ExpenseDataModel> get copyWith =>
      __$$_ExpenseDataModelCopyWithImpl<_$_ExpenseDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseDataModelToJson(
      this,
    );
  }
}

abstract class _ExpenseDataModel implements ExpenseDataModel {
  const factory _ExpenseDataModel(
      {required final String expense_categories,
      required final String amount,
      required final String expense_name,
      required final String created_at,
      final String? id}) = _$_ExpenseDataModel;

  factory _ExpenseDataModel.fromJson(Map<String, dynamic> json) =
      _$_ExpenseDataModel.fromJson;

  @override
  String get expense_categories;
  @override
  String get amount;
  @override
  String get expense_name;
  @override
  String get created_at;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseDataModelCopyWith<_$_ExpenseDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
