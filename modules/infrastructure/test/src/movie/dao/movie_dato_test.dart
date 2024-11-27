import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/src/movie/anticorruption/movie_translator.dart';
import 'package:infrastructure/src/movie/persistence/dao/movie_dao.dart';
import 'package:infrastructure/src/shared/persistence/movies_database.dart';

import '../builder/movie_data_builder.dart';

void main() {
  late MoviesDatabase database;
  setUp(() {
    database = MoviesDatabase.withQueryEx(NativeDatabase.memory());
  });
  tearDown(() async {
    await database.close();
  });
  group('insertMovies', () {
    test('> insert 1000 movies into db > recover all movies from db', () async {
      // Arrange
      const movieCount = 1000;
      final movieDao = MovieDao(database);
      final movies = MovieBuilder().buildMovieList(movieCount);
      // Act
      final moviesToDb = movies.map(MovieTranslator.fromDomainToDatabase).toList();
      await movieDao.insertMovies(moviesToDb);
      final recoveredMovies = await movieDao.getAllMovies();
      // Assert
      expect(movieCount, recoveredMovies.length);
    });
    test('> insert 4 movies into db > get all movies by id successfully', () async {
      // Arrange
      final movieDao = MovieDao(database);
      const movieCount = 4;
      final movies = MovieBuilder().buildMovieList(movieCount);

      // Act
      final moviesToDb = movies.map(MovieTranslator.fromDomainToDatabase).toList();
      await movieDao.insertMovies(moviesToDb);

      final movieId1 = await movieDao.getMovieById(0);
      final movieId2 = await movieDao.getMovieById(1);
      final movieId3 = await movieDao.getMovieById(2);
      final movieId4 = await movieDao.getMovieById(3);
      // Assert
      expect(movieId1?.id, equals(0));
      expect(movieId2?.id, equals(1));
      expect(movieId3?.id, equals(2));
      expect(movieId4?.id, equals(3));
    });
    test('> insert 1000 movies into db > count movies equals to 1000', () async {
      // Arrange
      const movieCount = 1000;
      final movieDao = MovieDao(database);
      final movies = MovieBuilder().buildMovieList(movieCount);

      // Act
      final moviesToDb = movies.map(MovieTranslator.fromDomainToDatabase).toList();
      await movieDao.insertMovies(moviesToDb);
      final recoveredMovies = await movieDao.getCountMovies();
      // Assert
      expect(recoveredMovies, equals(movieCount));
    });
    test('> verify if movie exist > return true', () async {
      // Arrange
      const idNotInList = 1234;
      const movieCount = 4;
      final movieDao = MovieDao(database);
      final movies = MovieBuilder().buildMovieList(movieCount);

      // Act
      final moviesToDb = movies.map(MovieTranslator.fromDomainToDatabase).toList();
      await movieDao.insertMovies(moviesToDb);
      // Assert
      expect(await movieDao.movieExist(0), equals(true));
      expect(await movieDao.movieExist(1), equals(true));
      expect(await movieDao.movieExist(2), equals(true));
      expect(await movieDao.movieExist(3), equals(true));
      expect(await movieDao.movieExist(idNotInList), equals(false));
    });
  });
}
