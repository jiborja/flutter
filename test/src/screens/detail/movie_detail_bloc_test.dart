import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/detail/bloc/movie_detail_bloc.dart';

import 'builder/movie_data_builder.dart';

class MockMovieService extends Mock implements MoviesService {}

void main() {
  late MoviesService movieService;
  late MovieDetailBloc movieDetailBloc;
  final movie = MovieBuilder().withId(1).withOverview('overview').build();
  final movieException = MovieBuilder().withId(-1).withOverview('overview').build();

  setUp(() {
    movieService = MockMovieService();
    movieDetailBloc = MovieDetailBloc(movieService: movieService, idMovie: movie.id);
  });

  group('MovieDetailBloc', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      '> get movie request > emit MovieDetailSuccess state',
      //Arrange
      build: () => movieDetailBloc,
      setUp: () {
        when(() => movieService.getMovie(movie.id)).thenAnswer((_) async => movie);
      },
      //act
      act: (bloc) => bloc.add(GetMovie()),
      //Assert
      expect: () => <MovieDetailState>[MovieDetailLoading(), MovieDetailSuccess(movie)],
    );
  
    blocTest<MovieDetailBloc, MovieDetailState>(
        '> get movie request > emit MovieDetailError state',
        //Arrange
        build: () => movieDetailBloc,
        setUp: () {
          when(() => movieService.getMovie(movieException.id)).thenThrow((_) => InvalidIdException());
        },
        //act
        act: (bloc) => bloc.add(GetMovie()),
        //Assert
        expect: () => [isA<MovieDetailLoading>(), isA<MovieDetailError>()],
      );
  });
}
