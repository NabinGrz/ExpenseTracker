import 'dart:async';

import 'package:expensetracker/features/login/bloc/login_event.dart';
import 'package:expensetracker/features/login/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../model/login_model.dart';

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
    on<LoginButtonPressedEvent>((event, emit) =>
        {emit(LoginButtonPressedState(loginDataModel: event.loginDataModel))});
    on<LoginSuccessEvent>((event, emit) => {emit(LoginSuccessState())});
    on<LoginFailedEvent>(
        (event, emit) => {emit(LoginFailedState(message: event.message))});
    on<LoggingUserEvent>((event, emit) => {emit(LoggingUserState())});
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

  Stream<LoginDataModel?> get enableButton =>
      Rx.combineLatest2(watchEmail(), watchPassword(), (a, b) {
        if (a != "" && b != "") {
          return LoginDataModel(email: a, password: b);
        }
        return null;
      });
  void firebaseUserLogin(
      {required String email, required String password}) async {
    add(LoggingUserEvent());
    final firebaseAuth = FirebaseAuth.instance;
    try {
      var dd = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      dd.additionalUserInfo;
      add(LoginSuccessEvent());
    } on FirebaseAuthException catch (e) {
      add(LoginFailedEvent(message: e.message ?? "Something went wrong!!"));
    }
  }

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    return super.close();
  }
}
