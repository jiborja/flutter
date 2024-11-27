part of 'user_detail_bloc.dart';

@immutable
class UserDetailEvent extends Equatable {
  const UserDetailEvent();
  @override
  List<Object?> get props => [];
}

class UserDetailSubmited extends UserDetailEvent {
  const UserDetailSubmited(this.age);
  final int age;
  @override
  List<Object?> get props => [age];
}
