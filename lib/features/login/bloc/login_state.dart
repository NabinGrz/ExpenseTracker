// part of 'login_bloc.dart';

import 'package:flutter/material.dart';

import '../model/login_model.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {
  LoginInitialState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginEmailUpdateState extends LoginState {
  final String email;

  LoginEmailUpdateState({
    required this.email,
  });
}

class LoginPasswordUpdateState extends LoginState {
  final String password;

  LoginPasswordUpdateState({
    required this.password,
  });
}

class LoginUserState extends LoginState {
  final String email;
  final String password;
  LoginUserState({
    required this.email,
    required this.password,
  });
}

class LoginButtonPressedState extends LoginState {
  final LoginDataModel loginDataModel;
  LoginButtonPressedState({required this.loginDataModel});
}

class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({required this.message});
}

class LoginSuccessState extends LoginState {
  LoginSuccessState();
}

class LoginEmailErrorState extends LoginState {
  LoginEmailErrorState();
}

class LoginPasswordErrorState extends LoginState {
  LoginPasswordErrorState();
}

class LoggingUserState extends LoginState {
  LoggingUserState();
}
