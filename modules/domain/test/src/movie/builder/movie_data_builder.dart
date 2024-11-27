import 'dart:math';

import 'package:domain/src/movie/model/movie.dart';

class MovieBuilder {
  MovieBuilder() {
    _adult = false;
    _id = 1;
    _originalLanguage = 'es';
    _overview = 'overview';
    _posterPath = 'posterPath';
    _releaseDate = DateTime.now().toString();
    _title = 'movie';
    _voteAverage = 1;
  }

  late bool _adult;

  late int _id;
  late String _originalLanguage;

  late String _overview;

  late String _posterPath;
  late String _releaseDate;
  late String _title;

  late double _voteAverage;

  MovieBuilder withAdult({required bool adultCatalogated}) {
    _adult = adultCatalogated;
    return this;
  }

  MovieBuilder withId(int id) {
    _id = id;
    return this;
  }

  MovieBuilder withOriginalLanguage(String originalLanguage) {
    _originalLanguage = originalLanguage;
    return this;
  }

  MovieBuilder withOverview(String overview) {
    _overview = overview;
    return this;
  }

  MovieBuilder withPosterPath(String posterPath) {
    _posterPath = posterPath;
    return this;
  }

  MovieBuilder withReleaseDate(String releaseDate) {
    _releaseDate = releaseDate;
    return this;
  }

  MovieBuilder withTitle(String title) {
    _title = title;
    return this;
  }

  MovieBuilder withVoteAverage(double voteAverage) {
    _voteAverage = voteAverage;
    return this;
  }

  Movie build() => Movie(
        id: _id,
        originalLanguage: _originalLanguage,
        overview: _overview,
        posterPath: _posterPath,
        releaseDate: _releaseDate,
        title: _title,
        voteAverage: _voteAverage,
        adult: _adult,
      );

  List<Movie> buildMovieList(int amount) {
    final random = Random();

    final movies = <Movie>[];

    for (var i = 0; i < amount; i++) {
      final randomBool = random.nextBool();
      final movie = withAdult(adultCatalogated: randomBool).withId(i).build();
      movies.add(movie);
    }

    return movies;
  }
}
