import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/home/home_screen.dart';
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:presentation/screens/user_detail/user_detail_form.dart';
import 'package:presentation/shared/auth/bloc/auth_bloc.dart';
import 'package:presentation/shared/theme.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  static const routeName = 'user-detail-screen';

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(const AuthStateLoggingOut());
        return false;
      },
      child: Scaffold(
        body: BlocConsumer<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is UserDetailInProccess) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MovieColors.primaryColor,
                ),
              );
            }

            return const UserDetailForm();
          },
          listener: (context, state) {
            if (state is UserDetailError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is UserDetailSuccess) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          },
        ),
      ),
    );
  }
}
