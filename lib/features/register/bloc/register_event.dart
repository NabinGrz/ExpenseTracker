import 'package:flutter/material.dart';

import '../model/register_model.dart';

@immutable
abstract class RegisterEventMain {}

class RegisterUserNameUpdateEvent extends RegisterEventMain {
  final String email;
  RegisterUserNameUpdateEvent({required this.email});
}

class RegisterPasswordUpdateEvent extends RegisterEventMain {
  final String password;
  RegisterPasswordUpdateEvent({required this.password});
}

class RegisterConfirmPasswordUpdateEvent extends RegisterEventMain {
  final String password;
  RegisterConfirmPasswordUpdateEvent({required this.password});
}

class RegisterButtonPressedEvent extends RegisterEventMain {
  final RegisterDataModel registerDataModel;
  RegisterButtonPressedEvent({required this.registerDataModel});
}

class RegisterSuccessEvent extends RegisterEventMain {
  RegisterSuccessEvent();
}

class RegisterFailedEvent extends RegisterEventMain {
  RegisterFailedEvent();
}

class RegisteringUserEvent extends RegisterEventMain {
  RegisteringUserEvent();
}
