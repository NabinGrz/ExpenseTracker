// part of 'login_bloc.dart';

import 'package:expensetracker/features/register/model/register_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterSState {}

class RegisterInitialState extends RegisterSState {
  RegisterInitialState();
}

class RegisterLoadingState extends RegisterSState {
  RegisterLoadingState();
}

class RegisterEmailUpdateState extends RegisterSState {
  final String email;

  RegisterEmailUpdateState({
    required this.email,
  });
}

class RegisterPasswordUpdateState extends RegisterSState {
  final String password;

  RegisterPasswordUpdateState({
    required this.password,
  });
}

class RegisterConfirmPasswordUpdateState extends RegisterSState {
  final String password;

  RegisterConfirmPasswordUpdateState({
    required this.password,
  });
}

class RegisterUserState extends RegisterSState {
  final String email;
  final String password;
  RegisterUserState({
    required this.email,
    required this.password,
  });
}

class RegisterButtonPressedState extends RegisterSState {
  final RegisterDataModel registerDataModel;
  RegisterButtonPressedState({required this.registerDataModel});
}

class RegisterFailedState extends RegisterSState {
  RegisterFailedState();
}

class RegisterSuccessState extends RegisterSState {
  RegisterSuccessState();
}

class RegisterEmailErrorState extends RegisterSState {
  RegisterEmailErrorState();
}

class RegisterPasswordErrorState extends RegisterSState {
  RegisterPasswordErrorState();
}

class RegisterConfirmPasswordErrorState extends RegisterSState {
  RegisterConfirmPasswordErrorState();
}

class RegisteringUserState extends RegisterSState {
  RegisteringUserState();
}
