// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegisterDataModel _$RegisterDataModelFromJson(Map<String, dynamic> json) {
  return _RegisterDataModel.fromJson(json);
}

/// @nodoc
mixin _$RegisterDataModel {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get confirmPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterDataModelCopyWith<RegisterDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterDataModelCopyWith<$Res> {
  factory $RegisterDataModelCopyWith(
          RegisterDataModel value, $Res Function(RegisterDataModel) then) =
      _$RegisterDataModelCopyWithImpl<$Res, RegisterDataModel>;
  @useResult
  $Res call({String? email, String? password, String? confirmPassword});
}

/// @nodoc
class _$RegisterDataModelCopyWithImpl<$Res, $Val extends RegisterDataModel>
    implements $RegisterDataModelCopyWith<$Res> {
  _$RegisterDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterDataModelCopyWith<$Res>
    implements $RegisterDataModelCopyWith<$Res> {
  factory _$$_RegisterDataModelCopyWith(_$_RegisterDataModel value,
          $Res Function(_$_RegisterDataModel) then) =
      __$$_RegisterDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password, String? confirmPassword});
}

/// @nodoc
class __$$_RegisterDataModelCopyWithImpl<$Res>
    extends _$RegisterDataModelCopyWithImpl<$Res, _$_RegisterDataModel>
    implements _$$_RegisterDataModelCopyWith<$Res> {
  __$$_RegisterDataModelCopyWithImpl(
      _$_RegisterDataModel _value, $Res Function(_$_RegisterDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
  }) {
    return _then(_$_RegisterDataModel(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RegisterDataModel implements _RegisterDataModel {
  const _$_RegisterDataModel({this.email, this.password, this.confirmPassword});

  factory _$_RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_RegisterDataModelFromJson(json);

  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? confirmPassword;

  @override
  String toString() {
    return 'RegisterDataModel(email: $email, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterDataModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, confirmPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterDataModelCopyWith<_$_RegisterDataModel> get copyWith =>
      __$$_RegisterDataModelCopyWithImpl<_$_RegisterDataModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RegisterDataModelToJson(
      this,
    );
  }
}

abstract class _RegisterDataModel implements RegisterDataModel {
  const factory _RegisterDataModel(
      {final String? email,
      final String? password,
      final String? confirmPassword}) = _$_RegisterDataModel;

  factory _RegisterDataModel.fromJson(Map<String, dynamic> json) =
      _$_RegisterDataModel.fromJson;

  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get confirmPassword;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterDataModelCopyWith<_$_RegisterDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
