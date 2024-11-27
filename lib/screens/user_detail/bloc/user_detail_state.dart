part of 'user_detail_bloc.dart';

@immutable
abstract class UserDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserDetailStarted extends UserDetailState {}

class UserDetailInProccess extends UserDetailState {}

class UserDetailSuccess extends UserDetailState {}

class UserDetailError extends UserDetailState {
  UserDetailError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
