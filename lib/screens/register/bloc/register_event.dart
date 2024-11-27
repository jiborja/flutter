part of 'register_bloc.dart';

@immutable
class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class RegisterSubmmited extends RegisterEvent {
  const RegisterSubmmited(this.email, this.password, this.userName);

  final String email;
  final String password;
  final String userName;

  @override
  List<Object?> get props => [email, password, userName];
}
