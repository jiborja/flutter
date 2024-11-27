part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  const HomeSuccess({required this.movies});
  final List<Movie> movies;
  @override
  List<Object> get props => [movies];
}

class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
