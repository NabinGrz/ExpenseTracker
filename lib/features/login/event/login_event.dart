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
  LoginButtonPressedEvent();
}

class LoginSuccessEvent extends LoginEventMain {
  LoginSuccessEvent();
}

class LoginFailedEvent extends LoginEventMain {
  LoginFailedEvent();
}

class LoginLoadingEvent extends LoginEventMain {
  LoginLoadingEvent();
}
