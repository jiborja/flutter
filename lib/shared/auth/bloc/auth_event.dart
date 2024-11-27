part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateInitialized extends AuthEvent {
  const AuthStateInitialized({required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  List<Object> get props => [navigatorKey];
}

class AuthStateLoggingOut extends AuthEvent {
  const AuthStateLoggingOut();
}
