import 'package:domain/domain.dart';
import 'package:domain/src/shared/exceptions/empty_param_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import 'builder/movie_data_builder.dart';

void main() {
  group('Movie', () {
    test('> create Movie with empty original language parameter > throws EmptyParamException', () {
      //Arrange
      const id = 1;
      const title = 'Movie 1';
      const originalLanguage = '';
      const overview = 'overview';
      const posterPath = 'path';
      const releaseDate = '04/04/2023';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        () => MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create Movie with empty overview parameter > throws EmptyParamException', () {
      //Arrange
      const id = 2;
      const title = 'Movie 2';
      const originalLanguage = 'en';
      const overview = '';
      const posterPath = 'path';
      const releaseDate = '04/04/2023';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        () => MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create Movie with empty poster path parameter > throws EmptyParamException', () {
      //Arrange
      const id = 3;
      const title = 'Movie 3';
      const originalLanguage = 'es';
      const overview = 'overview';
      const posterPath = '';
      const releaseDate = '04/04/2023';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        () => MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create Movie with empty release date parameter > throws EmptyParamException', () {
      //Arrange
      const id = 4;
      const title = 'Movie 4';
      const originalLanguage = 'fr';
      const overview = 'overview';
      const posterPath = 'path';
      const releaseDate = '';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        () => MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create Movie with empty title parameter > throws EmptyParamException', () {
      //Arrange
      const id = 5;
      const title = '';
      const originalLanguage = 'es';
      const overview = 'overview';
      const posterPath = 'path';
      const releaseDate = 'releaseDate';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        () => MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create Movie with valid Data > valid instance of Movie', () {
      //Arrange
      const id = 6;
      const title = 'Movie 6';
      const originalLanguage = 'en';
      const overview = 'overview';
      const posterPath = 'path';
      const releaseDate = 'releaseDate';
      const voteAverage = 10.0;
      const adult = false;

      //Act - Assert
      expect(
        MovieBuilder()
            .withId(id)
            .withTitle(title)
            .withOriginalLanguage(originalLanguage)
            .withOverview(overview)
            .withPosterPath(posterPath)
            .withReleaseDate(releaseDate)
            .withVoteAverage(voteAverage)
            .withAdult(adultCatalogated: adult)
            .build(),
        isA<Movie>(),
      );
    });
  });
}
