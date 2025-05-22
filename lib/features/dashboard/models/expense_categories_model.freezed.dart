// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_categories_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseCategoriesDataModel _$ExpenseCategoriesDataModelFromJson(
    Map<String, dynamic> json) {
  return _ExpenseCategoriesDataModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseCategoriesDataModel {
  List<String> get expense_type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCategoriesDataModelCopyWith<ExpenseCategoriesDataModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCategoriesDataModelCopyWith<$Res> {
  factory $ExpenseCategoriesDataModelCopyWith(ExpenseCategoriesDataModel value,
          $Res Function(ExpenseCategoriesDataModel) then) =
      _$ExpenseCategoriesDataModelCopyWithImpl<$Res,
          ExpenseCategoriesDataModel>;
  @useResult
  $Res call({List<String> expense_type});
}

/// @nodoc
class _$ExpenseCategoriesDataModelCopyWithImpl<$Res,
        $Val extends ExpenseCategoriesDataModel>
    implements $ExpenseCategoriesDataModelCopyWith<$Res> {
  _$ExpenseCategoriesDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense_type = null,
  }) {
    return _then(_value.copyWith(
      expense_type: null == expense_type
          ? _value.expense_type
          : expense_type // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpenseCategoriesDataModelCopyWith<$Res>
    implements $ExpenseCategoriesDataModelCopyWith<$Res> {
  factory _$$_ExpenseCategoriesDataModelCopyWith(
          _$_ExpenseCategoriesDataModel value,
          $Res Function(_$_ExpenseCategoriesDataModel) then) =
      __$$_ExpenseCategoriesDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> expense_type});
}

/// @nodoc
class __$$_ExpenseCategoriesDataModelCopyWithImpl<$Res>
    extends _$ExpenseCategoriesDataModelCopyWithImpl<$Res,
        _$_ExpenseCategoriesDataModel>
    implements _$$_ExpenseCategoriesDataModelCopyWith<$Res> {
  __$$_ExpenseCategoriesDataModelCopyWithImpl(
      _$_ExpenseCategoriesDataModel _value,
      $Res Function(_$_ExpenseCategoriesDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expense_type = null,
  }) {
    return _then(_$_ExpenseCategoriesDataModel(
      expense_type: null == expense_type
          ? _value._expense_type
          : expense_type // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpenseCategoriesDataModel implements _ExpenseCategoriesDataModel {
  const _$_ExpenseCategoriesDataModel(
      {required final List<String> expense_type})
      : _expense_type = expense_type;

  factory _$_ExpenseCategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseCategoriesDataModelFromJson(json);

  final List<String> _expense_type;
  @override
  List<String> get expense_type {
    if (_expense_type is EqualUnmodifiableListView) return _expense_type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expense_type);
  }

  @override
  String toString() {
    return 'ExpenseCategoriesDataModel(expense_type: $expense_type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpenseCategoriesDataModel &&
            const DeepCollectionEquality()
                .equals(other._expense_type, _expense_type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_expense_type));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpenseCategoriesDataModelCopyWith<_$_ExpenseCategoriesDataModel>
      get copyWith => __$$_ExpenseCategoriesDataModelCopyWithImpl<
          _$_ExpenseCategoriesDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseCategoriesDataModelToJson(
      this,
    );
  }
}

abstract class _ExpenseCategoriesDataModel
    implements ExpenseCategoriesDataModel {
  const factory _ExpenseCategoriesDataModel(
          {required final List<String> expense_type}) =
      _$_ExpenseCategoriesDataModel;

  factory _ExpenseCategoriesDataModel.fromJson(Map<String, dynamic> json) =
      _$_ExpenseCategoriesDataModel.fromJson;

  @override
  List<String> get expense_type;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseCategoriesDataModelCopyWith<_$_ExpenseCategoriesDataModel>
      get copyWith => throw _privateConstructorUsedError;
}
