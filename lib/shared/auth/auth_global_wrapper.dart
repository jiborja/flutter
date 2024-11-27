import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/dependencyInjection/dependency_injection.dart';
import 'package:presentation/shared/auth/bloc/auth_bloc.dart';

class AuthGlobalWrapper {
  static Widget Function({
    required BuildContext context,
    required Widget child,
    required GlobalKey<NavigatorState> navigatorKey,
  }) build = ({
    required BuildContext context,
    required Widget child,
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()
        ..add(AuthStateInitialized(navigatorKey: navigatorKey)),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  };
}
