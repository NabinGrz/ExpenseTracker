import 'package:expensetracker/features/dashboard/screen/dashboard_screen.dart';
import 'package:expensetracker/features/login/bloc/login_bloc.dart';
import 'package:expensetracker/features/login/bloc/login_event.dart';
import 'package:expensetracker/features/login/bloc/login_state.dart';
import 'package:expensetracker/features/login/model/login_model.dart';
import 'package:expensetracker/features/register/screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/clear_focus.dart';
import '../../../core/utils/snackbar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: true,
        create: (
          _,
        ) =>
            LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginStateMain>(
          listener: (loginContext, state) {
            if (state is LoginButtonPressedState) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text("$state")));
              loginContext.read<LoginBloc>().firebaseUserLogin(
                  email: state.loginDataModel.email!,
                  password: state.loginDataModel.password!);
            } else if (state is LoginSuccessState) {
              clearFocus();
              showSnackBar(
                  message: "User Logged Successfully!!",
                  type: SnackBarTypes.Success);
              emailController.clear();
              passwordController.clear();
              Navigator.push(context, CupertinoPageRoute(
                builder: (context) {
                  return const DashboardScreen();
                },
              ));
            } else if (state is LoginFailedState) {
              clearFocus();
              showSnackBar(message: state.message, type: SnackBarTypes.Error);
            }
            // else if (state is LoginEmailUpdateState) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text("$state")));
            // } else if (state is LoginPasswordUpdateState) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text("$state")));
            // }
          },
          builder: (loginContext, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder()),
                    onChanged: (email) {
                      loginContext.read<LoginBloc>().updateEmail(email);
                      // loginContext
                      //     .read<LoginBloc>()
                      //     .add(LoginUserNameUpdateEvent(email: value));
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder()),
                    onChanged: (password) {
                      loginContext.read<LoginBloc>().updatePassword(password);
                      // loginContext
                      //     .read<LoginBloc>()
                      //     .add(LoginPasswordUpdateEvent(password: value));
                      // loginContext
                      //     .watch<LoginBloc>()
                      //     .add(LoginPasswordUpdateEvent(password: value));
                    },
                  ),
                  StreamBuilder<LoginDataModel?>(
                      stream: loginContext.watch<LoginBloc>().enableButton,
                      builder:
                          (context, AsyncSnapshot<LoginDataModel?> snapshot) {
                        return ElevatedButton(
                            onPressed: snapshot.data == null
                                ? null
                                : () {
                                    loginContext.read<LoginBloc>().add(
                                        LoginButtonPressedEvent(
                                            loginDataModel: snapshot.data!));
                                  },
                            child: state is LoggingUserState
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Login"));
                      }),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return RegisterScreen();
                          },
                        ));
                      },
                      child: const Text("Register"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
