part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends MovieDetailState {
  const MovieDetailSuccess(this.movie);
  final Movie? movie;
}

class MovieDetailError extends MovieDetailState {
  const MovieDetailError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
