// part of 'login_bloc.dart';

import 'package:flutter/material.dart';

import '../model/login_model.dart';

@immutable
abstract class LoginStateMain {}

class LoginInitialState extends LoginStateMain {
  LoginInitialState();
}

class LoginLoadingState extends LoginStateMain {
  LoginLoadingState();
}

class LoginEmailUpdateState extends LoginStateMain {
  final String email;

  LoginEmailUpdateState({
    required this.email,
  });
}

class LoginPasswordUpdateState extends LoginStateMain {
  final String password;

  LoginPasswordUpdateState({
    required this.password,
  });
}

class LoginUserState extends LoginStateMain {
  final String email;
  final String password;
  LoginUserState({
    required this.email,
    required this.password,
  });
}

class LoginButtonPressedState extends LoginStateMain {
  final LoginDataModel loginDataModel;
  LoginButtonPressedState({required this.loginDataModel});
}

class LoginFailedState extends LoginStateMain {
  final String message;
  LoginFailedState({required this.message});
}

class LoginSuccessState extends LoginStateMain {
  LoginSuccessState();
}

class LoginEmailErrorState extends LoginStateMain {
  LoginEmailErrorState();
}

class LoginPasswordErrorState extends LoginStateMain {
  LoginPasswordErrorState();
}

class LoggingUserState extends LoginStateMain {
  LoggingUserState();
}
