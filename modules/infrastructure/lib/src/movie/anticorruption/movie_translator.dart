import 'package:domain/domain.dart' as movie_domain;
import 'package:drift/drift.dart';
import 'package:infrastructure/src/movie/http_client/dto/movie.dart';
import 'package:infrastructure/src/shared/persistence/movies_database.dart';

class MovieTranslator {
  static movie_domain.Movie fromDtoToDomain(Movie movieDto) {
    return movie_domain.Movie(
      id: movieDto.id,
      originalLanguage: movieDto.originalLanguage,
      overview: movieDto.overview,
      posterPath: movieDto.posterPath,
      releaseDate: movieDto.releaseDate,
      title: movieDto.title,
      voteAverage: movieDto.voteAverage,
      adult: movieDto.adult,
    );
  }

  static movie_domain.Movie fromDatabaseToDomain(MovieEntityData movieEntity) {
    return movie_domain.Movie(
      id: movieEntity.id,
      originalLanguage: movieEntity.originalLanguage,
      overview: movieEntity.overview,
      posterPath: movieEntity.posterPath,
      releaseDate: movieEntity.releaseDate,
      title: movieEntity.title,
      voteAverage: movieEntity.voteAverage,
      adult: movieEntity.adult,
    );
  }

  static MovieEntityCompanion fromDomainToDatabase(movie_domain.Movie movie) {
    return MovieEntityCompanion(
      id: Value(movie.id),
      adult: Value(movie.adult),
      originalLanguage: Value(movie.originalLanguage),
      overview: Value(movie.overview),
      posterPath: Value(movie.posterPath),
      releaseDate: Value(movie.releaseDate),
      title: Value(movie.title),
      voteAverage: Value(movie.voteAverage),
    );
  }
}
