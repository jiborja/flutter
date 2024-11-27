import 'package:domain/src/movie/exceptions/movie_exception.dart';

class NoDataMovieException extends MovieException {
  NoDataMovieException() : super(_noDataMovieExceptionMessage);

  static const _noDataMovieExceptionMessage = 'We have no movies to show';
}
