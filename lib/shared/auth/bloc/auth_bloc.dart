import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/screens/login/login_screen.dart';
import 'package:presentation/screens/user_detail/user_detail_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitialized()) {
    on<AuthStateInitialized>(_authStreamUpdater);
    on<AuthStateLoggingOut>(_logOut);
  }

  final AuthRepository _authRepository;

  Future<void> _authStreamUpdater(
    AuthStateInitialized event,
    Emitter<AuthState> emit,
  ) async =>
      emit.forEach(
        _authRepository.authState,
        onData: (user) {
          if (user != null && state is! AuthLoggedIn) {
            event.navigatorKey.currentState!.pushNamed(UserDetailScreen.routeName);
            return AuthLoggedIn(user: user);
          }
          if (user == null) {
            event.navigatorKey.currentState!.popUntil(ModalRoute.withName(LoginScreen.routeName));
            return const AuthLoggedOut();
          }
          return AuthLoggedIn(user: user);
        },
      );

  Future<void> _logOut(
    AuthStateLoggingOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.logOut();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
