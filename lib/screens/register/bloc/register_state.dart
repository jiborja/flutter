part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterStarted extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterSucess extends RegisterState {}

class RegisterError extends RegisterState {
  RegisterError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
