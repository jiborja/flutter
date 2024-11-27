import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_local_repository.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_remote_repository.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_temporal_repository.dart';
import 'package:infrastructure/src/shared/network/network_verify.dart';

import 'package:mocktail/mocktail.dart';

import '../builder/movie_data_builder.dart';

class MockMovieLocalRepository extends Mock implements MovieLocalRepository {}

class MockMovieRemoteRepository extends Mock implements MovieRemoteRepository {}

class MockMovieTemporalRepository extends Mock implements MovieTemporalRepository {}

class MockAnalyticsRepository extends Mock implements AnalyticsRepository {}

class MockNetworkVerify extends Mock implements NetworkVerify {}

void main() {
  final movie = MovieBuilder().build();
  final movies = MovieBuilder().buildMovieList(10);
  late MovieLocalRepository movieLocalRepository;
  late MovieRemoteRepository movieRemoteRepository;
  late MovieTemporalRepository movieTemporalRepository;
  late MovieProxy movieCachedProxy;
  late AnalyticsRepository analyticsRepository;
  late NetworkVerify networkVerify;

  setUp(() async {
    movieLocalRepository = MockMovieLocalRepository();
    movieRemoteRepository = MockMovieRemoteRepository();
    movieTemporalRepository = MockMovieTemporalRepository();
    analyticsRepository = MockAnalyticsRepository();
    networkVerify = MockNetworkVerify();
    registerFallbackValue(Event(name: 'prueba', data: 'prueba'));

    movieCachedProxy = MovieProxy(
      movieLocalRepository: movieLocalRepository,
      remoteRepository: movieRemoteRepository,
      temporalRepository: movieTemporalRepository,
      analyticsRepository: analyticsRepository,
      networkVerify: networkVerify,
    );
  });

  group('getMovie', () {
    test('> movie request when is local repository > instance of Movie', () async {
      //Arrange
      final idMovie = movies[0].id;

      when(() => movieLocalRepository.getMovie(idMovie)).thenAnswer((_) async => movies[0]);
      when(
        () => analyticsRepository.registerEvent(any()),
      ).thenAnswer((_) async => {});
      when(() => movieLocalRepository.getMovie(any())).thenAnswer((_) async => movie);

      //Act
      final result = await movieCachedProxy.getMovie(movie.id);

      //Assert
      verify(() => movieLocalRepository.getMovie(movie.id)).called(1);
      expect(movie, result);
    });
  });

  group('getMovies', () {
    test('> movie list request when local repository is empty > get movies from movieRemoteRepository', () async {
      //Arrange
      final updateMillis = DateTime.now().millisecondsSinceEpoch.toString();
      when(() => movieTemporalRepository.getLastUpdatedPreference()).thenAnswer((_) async => updateMillis);
      when(() => movieLocalRepository.isEmpty()).thenAnswer((_) async => true);
      when(() => movieRemoteRepository.getMovies()).thenAnswer((_) async => movies);
      when(
        () => movieTemporalRepository.saveLastUpdatedPreference(
          any(),
        ),
      ).thenAnswer((_) => Future.value());
      when(() => movieLocalRepository.insertMovies(movies)).thenAnswer((_) => Future.value());
      when(() => networkVerify.isConnected).thenAnswer((_) async => true);

      //Act
      final result = await movieCachedProxy.getMovies();
      //Assert
      verify(() => movieTemporalRepository.getLastUpdatedPreference()).called(1);
      verify(() => movieLocalRepository.isEmpty()).called(1);
      verifyNever(() => movieLocalRepository.getMovies());
      verify(() => movieRemoteRepository.getMovies()).called(1);
      verify(() => movieLocalRepository.insertMovies(movies)).called(1);
      verify(
        () => movieTemporalRepository.saveLastUpdatedPreference(any()),
      ).called(1);
      expect(movies, result);
    });

    test('> movie list request when local repository is not empty and is updated > get movies from movieLocalRepository', () async {
      //Arrange
      final updateMillis = DateTime.now().millisecondsSinceEpoch.toString();
      when(() => movieTemporalRepository.getLastUpdatedPreference()).thenAnswer((_) async => updateMillis);
      when(() => movieLocalRepository.isEmpty()).thenAnswer((_) async => false);
      when(() => movieLocalRepository.getMovies()).thenAnswer((_) async => movies);

      //Act
      final result = await movieCachedProxy.getMovies();
      //Assert
      verify(() => movieTemporalRepository.getLastUpdatedPreference()).called(1);
      verify(() => movieLocalRepository.isEmpty()).called(1);
      verify(() => movieLocalRepository.getMovies()).called(1);
      verifyNever(() => movieRemoteRepository.getMovies());
      expect(movies, result);
    });

    test('> movie list request when local repository is not updated > get movies from movieRemoteRepository', () async {
      //Arrange
      final actualDate = DateTime.now().millisecondsSinceEpoch;
      final updateMillis = actualDate - 3700000;
      when(() => movieTemporalRepository.getLastUpdatedPreference()).thenAnswer((_) async => updateMillis.toString());
      when(() => movieLocalRepository.isEmpty()).thenAnswer((_) async => false);
      when(() => movieRemoteRepository.getMovies()).thenAnswer((_) async => movies);
      when(
        () => movieTemporalRepository.saveLastUpdatedPreference(
          any(),
        ),
      ).thenAnswer((_) => Future.value());
      when(() => movieLocalRepository.insertMovies(movies)).thenAnswer((_) => Future.value());
      when(() => networkVerify.isConnected).thenAnswer((_) async => true);
      //Act
      final result = await movieCachedProxy.getMovies();
      //Assert
      verify(() => movieTemporalRepository.getLastUpdatedPreference()).called(1);
      verify(() => movieLocalRepository.isEmpty()).called(1);
      verifyNever(() => movieLocalRepository.getMovies());
      verify(() => movieRemoteRepository.getMovies()).called(1);
      verify(() => movieLocalRepository.insertMovies(movies)).called(1);
      verify(() => movieTemporalRepository.saveLastUpdatedPreference(any())).called(1);

      expect(movies, result);
    });

    test('> movie list request when device is offline > throws NotConnectedToNetworkException', () async {
      //Arrange
      final actualDate = DateTime.now().millisecondsSinceEpoch;
      final updateMillis = actualDate - 3700000;
      when(() => movieTemporalRepository.getLastUpdatedPreference()).thenAnswer((_) async => updateMillis.toString());
      when(() => movieLocalRepository.isEmpty()).thenAnswer((_) async => false);
      when(() => networkVerify.isConnected).thenAnswer((_) => Future.value(false));
      //Assert
      expect(
        () async => movieCachedProxy.getMovies(),
        throwsA(isA<NotConnectedToNetworkException>().having((e) => e.toString(), 'message', contains('Not connected to network'))),
      );
    });
  });
}
