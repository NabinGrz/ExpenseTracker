import 'package:expensetracker/features/login/model/login_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEventMain {}

class LoginUserNameUpdateEvent extends LoginEventMain {
  final String email;
  LoginUserNameUpdateEvent({required this.email});
}

class LoginPasswordUpdateEvent extends LoginEventMain {
  final String password;
  LoginPasswordUpdateEvent({required this.password});
}

class LoginButtonPressedEvent extends LoginEventMain {
  final LoginDataModel loginDataModel;
  LoginButtonPressedEvent({required this.loginDataModel});
}

class LoginSuccessEvent extends LoginEventMain {
  LoginSuccessEvent();
}

class LoginFailedEvent extends LoginEventMain {
  final String message;
  LoginFailedEvent({required this.message});
}

class LoggingUserEvent extends LoginEventMain {
  LoggingUserEvent();
}
