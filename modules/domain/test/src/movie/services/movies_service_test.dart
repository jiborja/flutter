import 'package:domain/domain.dart';
import 'package:domain/src/movie/exceptions/invalid_id_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../builder/movie_data_builder.dart';

class MockMovieProxy extends Mock implements MovieRepository {}

void main() {
  late Movie movie;
  late MoviesService moviesService;
  late MockMovieProxy movieProxy;

  setUp(() {
    movie = MovieBuilder().withId(10).build();
    movieProxy = MockMovieProxy();
    moviesService = MoviesService(movieRepository: movieProxy);
  });

  group('getMovies', () {
    test('> movie list request > valid list of movies', () async {
      //Arrange
      final userDetail = UserDetail(age: 10);
      when(() => movieProxy.getMovies()).thenAnswer((_) async => [movie]);
      //Act
      final result = await moviesService.getMovies(userDetail);
      //Assert
      verify(() => movieProxy.getMovies()).called(1);
      expect([movie], result);
    });

    test('> user under 18 years old request for movie list > movie list response without adult movies', () async {
      //Arrange
      final userDetail = UserDetail(age: 10);
      final movies = MovieBuilder().buildMovieList(10);
      final originalAdultMoviesCount = movies.where((element) => element.adult).length;
      when(() => movieProxy.getMovies()).thenAnswer((_) async => movies);

      //Act
      final moviesResult = await moviesService.getMovies(userDetail);
      final adultMoviesCount = moviesResult.where((element) => element.adult).length;

      //Assert
      expect(originalAdultMoviesCount, greaterThan(adultMoviesCount));
      expect(0, adultMoviesCount);
    });

    test('> user golder than 18 years old request, for movie list > movie list response with adult movies', () async {
      //Arrange
      final userDetail = UserDetail(age: 25);
      final movies = MovieBuilder().buildMovieList(10);
      final originalAdultMoviesCount = movies.where((element) => element.adult).length;
      when(() => movieProxy.getMovies()).thenAnswer((_) async => movies);

      //Act
      final moviesResult = await moviesService.getMovies(userDetail);
      final adultMoviesCount = moviesResult.where((element) => element.adult).length;

      //Assert
      expect(originalAdultMoviesCount, adultMoviesCount);
    });

    test('> movie list request > throws NoDataMovieException', () async {
      //Arrange
      final userDetail = UserDetail(age: 10);
      when(() => movieProxy.getMovies()).thenThrow(NoDataMovieException);
      //Act
      final futureGetMovies = moviesService.getMovies(userDetail);
      //Assert
      verify(() => movieProxy.getMovies()).called(1);
      await expectLater(futureGetMovies, throwsA(NoDataMovieException));
    });
  });

  group('getMovie', () {
    test('> movie request with existing id movie > return valid instance of Movie', () async {
      //Arrange
      const validId = 0;
      final movie = MovieBuilder().withId(validId).build();
      when(() => movieProxy.getMovie(any())).thenAnswer((_) async => movie);
      //Act
      final result = await moviesService.getMovie(movie.id);
      //Assert
      verify(() => movieProxy.getMovie(validId)).called(1);
      expect(movie, result);
    });

    test('> movie request with invalid id that not exists > return null', () async {
      //Arrange
      const validId = 0;
      when(() => movieProxy.getMovie(any())).thenAnswer((_) async => null);
      //Act
      final result = await moviesService.getMovie(validId);
      //Assert
      verify(() => movieProxy.getMovie(validId)).called(1);
      expect(null, result);
    });

    test('> movie list request with valid id that exists > return instance of Movie', () async {
      //Arrange
      const validId = 0;
      final movie = MovieBuilder().withId(validId).build();
      when(() => movieProxy.getMovie(any())).thenAnswer((_) async => movie);
      //Act
      final result = await moviesService.getMovie(validId);
      //Assert
      verify(() => movieProxy.getMovie(validId)).called(1);
      expect(movie, result);
    });

    test('> movie request with negative id number > throws InvalidIdException', () async {
      //Arrange
      const invalidId = -1;
      //Act
      final futureMovie = moviesService.getMovie(invalidId);
      //Assert
      verifyNever(() => movieProxy.getMovie(invalidId));
      await expectLater(futureMovie, throwsA(isA<InvalidIdException>()));
    });
  });
}
