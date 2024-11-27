part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialized extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  const AuthLoggedIn({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
