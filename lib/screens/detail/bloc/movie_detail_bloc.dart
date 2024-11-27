import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required MoviesService movieService,
    @factoryParam required int idMovie,
  }) : super(MovieDetailInitial()) {
    on<GetMovie>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final result = await movieService.getMovie(idMovie);
        emit(MovieDetailSuccess(result));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    debugPrint('MovieDetailBloc - close');
    return super.close();
  }
}
