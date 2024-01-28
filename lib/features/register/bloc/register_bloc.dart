import 'dart:async';

import 'package:expensetracker/features/register/bloc/register_event.dart';
import 'package:expensetracker/features/register/bloc/register_state.dart';
import 'package:expensetracker/features/register/model/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEventMain, RegisterSState> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterUserNameUpdateEvent>((event, emit) => {
          if (event.email.isEmpty)
            {emit(RegisterEmailErrorState())}
          else
            {emit(RegisterEmailUpdateState(email: event.email))}
        });
    on<RegisterPasswordUpdateEvent>((event, emit) => {
          if (event.password.isEmpty)
            {emit(RegisterPasswordErrorState())}
          else
            {emit(RegisterPasswordUpdateState(password: event.password))}
        });
    on<RegisterConfirmPasswordUpdateEvent>((event, emit) => {
          if (event.password.isEmpty)
            {emit(RegisterConfirmPasswordErrorState())}
          else
            {emit(RegisterConfirmPasswordUpdateState(password: event.password))}
        });
    on<RegisterButtonPressedEvent>((event, emit) => emit(RegisterButtonPressedState(
              registerDataModel: event.registerDataModel))
        );
    on<RegisteringUserEvent>((event, emit) => emit(RegisteringUserState()));
    on<RegisterSuccessEvent>((event, emit) => emit(RegisterSuccessState()));
    on<RegisterFailedEvent>((event, emit) => emit(RegisterFailedState()));
  }

  updateEmail(String email) {
    _emailController.add(email);
  }

  updatePassword(String password) {
    _passwordController.add(password);
  }

  updateConfirmPassword(String password) {
    _confirmPasswordController.add(password);
  }

  final _emailController = BehaviorSubject<String>();
  Stream<String> watchEmail() => _emailController.stream;

  final _passwordController = BehaviorSubject<String>();
  Stream<String> watchPassword() => _passwordController.stream;

  final _confirmPasswordController = BehaviorSubject<String>();
  Stream<String> watchConfirmPassword() => _confirmPasswordController.stream;

  Stream<RegisterDataModel?> get enableRegisterButton =>
      Rx.combineLatest3(watchEmail(), watchPassword(), watchConfirmPassword(),
          (a, b, c) {
        if ((a != "" && b != "" && c != "")) {
          return RegisterDataModel.fromJson({
            'email': a,
            'password': b,
            'confirmPassword': c,
          });
        } else {
          return null;
        }
      });

  void firebaseRegisterUser(
      {required String email, required String password}) async {
    add(RegisteringUserEvent());
    try {
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      add(RegisterSuccessEvent());
    } on Exception {
      add(RegisterFailedEvent());
    } finally {}
  }

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    return super.close();
  }
}
