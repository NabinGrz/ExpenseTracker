import 'package:expensetracker/core/utils/clear_focus.dart';
import 'package:expensetracker/core/utils/snackbar.dart';
import 'package:expensetracker/features/login/screen/login_screen.dart';
import 'package:expensetracker/features/register/model/register_model.dart';
import 'package:expensetracker/global_widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: true,
        create: (
          _,
        ) =>
            RegisterBloc(),
        child: BlocConsumer<RegisterBloc, RegisterSState>(
          listener: (loginContext, state) {
            if (state is RegisterButtonPressedState) {
              loginContext.read<RegisterBloc>().firebaseRegisterUser(
                  email: state.registerDataModel.email!,
                  password: state.registerDataModel.password!);
            } else if (state is RegisterSuccessState) {
              clearFocus();
              showSnackBar(
                  message: "User Created Successfully!!",
                  type: SnackBarTypes.Success);
              emailController.clear();
              passwordController.clear();
              confirmPasswordController.clear();
              Navigator.push(context, CupertinoPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ));
            } else if (state is RegisterFailedState) {
              clearFocus();
              showSnackBar(
                  message: "Something went wrong!!", type: SnackBarTypes.Error);
            }
          },
          builder: (loginContext, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormField(
                      hintText: "example@gmail.com",
                      controller: emailController,
                      icon: const Icon(Icons.email),
                      onChanged: (email) {
                        loginContext.read<RegisterBloc>().updateEmail(email);
                      }),
                  textFormField(
                      controller: passwordController,
                      icon: const Icon(Icons.password),
                      onChanged: (password) {
                        loginContext
                            .read<RegisterBloc>()
                            .updatePassword(password);
                      }),
                  textFormField(
                      controller: confirmPasswordController,
                      icon: const Icon(Icons.password),
                      onChanged: (password) {
                        loginContext
                            .read<RegisterBloc>()
                            .updateConfirmPassword(password);
                      }),
                  StreamBuilder<RegisterDataModel?>(
                      stream: loginContext
                          .watch<RegisterBloc>()
                          .enableRegisterButton,
                      builder: (context,
                          AsyncSnapshot<RegisterDataModel?> snapshot) {
                        return ElevatedButton(
                            onPressed: snapshot.data == null
                                ? null
                                : () async {
                                    loginContext.read<RegisterBloc>().add(
                                        RegisterButtonPressedEvent(
                                            registerDataModel: snapshot.data!));
                                  },
                            child: state is RegisteringUserState
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Register"));
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
