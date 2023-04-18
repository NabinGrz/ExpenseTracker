import 'dart:async';

import 'package:expensetracker/features/login/event/login_event.dart';
import 'package:expensetracker/features/login/state/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEventMain, LoginStateMain> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserNameUpdateEvent>((event, emit) => {
          if (event.email.isEmpty)
            {emit(LoginEmailErrorState())}
          else
            {emit(LoginEmailUpdateState(email: event.email))}
        });
    on<LoginPasswordUpdateEvent>((event, emit) => {
          if (event.password.isEmpty)
            {emit(LoginPasswordErrorState())}
          else
            {emit(LoginPasswordUpdateState(password: event.password))}
        });
    on<LoginButtonPressedEvent>((event, emit) => {
          emit(LoginButtonPressedState())
          // if (event.password.isEmpty)
          //   {emit(LoginEmailErrorState())}
          // else
          //   {emit(LoginEmailUpdateState(email: event.password))}
        });
  }
  updateEmail(String email) {
    _emailController.add(email);
  }

  updatePassword(String password) {
    _passwordController.add(password);
  }

  final _emailController = BehaviorSubject<String>();
  Stream<String> watchEmail() => _emailController.stream;

  final _passwordController = BehaviorSubject<String>();
  Stream<String> watchPassword() => _passwordController.stream;
  // Future<bool> enableButton() async {
  //   return await _emailController.stream.isEmpty &&
  //       await _passwordController.stream.isEmpty;
  // }
  Stream<bool> get enableButton => Rx.combineLatest2(
      watchEmail(), watchPassword(), (a, b) => (a != "" && b != ""));
  // final StreamController<bool> _enableButtonController =
  //     StreamController<bool>();
  // Stream<bool> get enableButton =>
  //     StreamZip([_emailController.stream, _passwordController.stream])
  //         .map((event) {
  //       event;
  //       return event.every((val) => val.isNotEmpty && val != "");
  //     });

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    return super.close();
  }
}
