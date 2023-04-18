import 'package:expensetracker/features/login/bloc/login_bloc.dart';
import 'package:expensetracker/features/login/event/login_event.dart';
import 'package:expensetracker/features/login/state/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$state")));
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
                  StreamBuilder<bool>(
                      stream: loginContext.watch<LoginBloc>().enableButton,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return ElevatedButton(
                            onPressed: snapshot.data == null || !snapshot.data!
                                ? null
                                : () {
                                    loginContext
                                        .read<LoginBloc>()
                                        .add(LoginButtonPressedEvent());
                                  },
                            child: Text("Login ${snapshot.data}"));
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
