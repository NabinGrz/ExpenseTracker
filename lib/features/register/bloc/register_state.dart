// part of 'login_bloc.dart';

import 'package:expensetracker/features/register/model/register_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterStateMain {}

class RegisterInitialState extends RegisterStateMain {
  RegisterInitialState();
}

class RegisterLoadingState extends RegisterStateMain {
  RegisterLoadingState();
}

class RegisterEmailUpdateState extends RegisterStateMain {
  final String email;

  RegisterEmailUpdateState({
    required this.email,
  });
}

class RegisterPasswordUpdateState extends RegisterStateMain {
  final String password;

  RegisterPasswordUpdateState({
    required this.password,
  });
}

class RegisterConfirmPasswordUpdateState extends RegisterStateMain {
  final String password;

  RegisterConfirmPasswordUpdateState({
    required this.password,
  });
}

class RegisterUserState extends RegisterStateMain {
  final String email;
  final String password;
  RegisterUserState({
    required this.email,
    required this.password,
  });
}

class RegisterButtonPressedState extends RegisterStateMain {
  final RegisterDataModel registerDataModel;
  RegisterButtonPressedState({required this.registerDataModel});
}

class RegisterFailedState extends RegisterStateMain {
  RegisterFailedState();
}

class RegisterSuccessState extends RegisterStateMain {
  RegisterSuccessState();
}

class RegisterEmailErrorState extends RegisterStateMain {
  RegisterEmailErrorState();
}

class RegisterPasswordErrorState extends RegisterStateMain {
  RegisterPasswordErrorState();
}

class RegisterConfirmPasswordErrorState extends RegisterStateMain {
  RegisterConfirmPasswordErrorState();
}

class RegisteringUserState extends RegisterStateMain {
  RegisteringUserState();
}
