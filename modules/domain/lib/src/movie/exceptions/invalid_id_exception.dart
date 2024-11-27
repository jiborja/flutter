import 'package:domain/src/movie/exceptions/movie_exception.dart';

class InvalidIdException extends MovieException {
  InvalidIdException() : super(_invalidIdExceptionMessage);

  static const _invalidIdExceptionMessage =
      'Movie identifier cannot be negative.';
}
