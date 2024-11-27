import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/dependencyInjection/dependency_injection.dart';
import 'package:presentation/screens/detail/bloc/movie_detail_bloc.dart';
import 'package:presentation/screens/detail/movie_detail_screen.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/screens/home/home_screen.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/login_screen.dart';
import 'package:presentation/screens/register/bloc/register_bloc.dart';
import 'package:presentation/screens/register/register_screen.dart';
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:presentation/screens/user_detail/user_detail_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (context) => BlocProvider(
          create: (context) => getIt<LoginBloc>(),
          child: const LoginScreen(),
        ),
    RegisterScreen.routeName: (context) => BlocProvider(
          create: (_) => getIt<RegisterBloc>(),
          child: const RegisterScreen(),
        ),
    UserDetailScreen.routeName: (context) => BlocProvider(
          create: (context) => getIt<UserDetailBloc>(),
          child: const UserDetailScreen(),
        ),
    HomeScreen.routeName: (context) => BlocProvider(
          create: (_) => getIt<HomeBloc>()..add(GetMovies()),
          child: const HomeScreen(),
        ),
  };

  static const int _transitionDurationInMillis = 550;

  static RouteFactory onGenerateRoute = (RouteSettings settings) {
    final name = settings.name;

    if (name == MovieDetailScreen.routeName) {
      const transitionDuration =
          Duration(milliseconds: _transitionDurationInMillis);
      final args = settings.arguments;

      return PageRouteBuilder(
        transitionDuration: transitionDuration,
        reverseTransitionDuration: transitionDuration,
        pageBuilder: (_, animation, ___) {
          return FadeTransition(
            opacity: animation,
            child: BlocProvider(
              create: (_) =>
                  getIt<MovieDetailBloc>(param1: args)..add(GetMovie()),
              child: const MovieDetailScreen(),
            ),
          );
        },
      );
    }
    return null;
  };
}
