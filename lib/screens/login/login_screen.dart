import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/widgets/login_form.dart';
import 'package:presentation/shared/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = 'login-screen';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<LoginBloc, LoginState>(
            bloc: bloc,
            builder: (context, state) {
              return Stack(
                children: [
                  const LoginForm(),
                  if (state is LoginLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: MovieColors.primaryColor,
                      ),
                    ),
                ],
              );
            },
            listener: (context, state) {
              if (state is LoginError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ),
      ),
    );
  }
}
