import 'package:domain/domain.dart';
import 'package:domain/src/movie/exceptions/invalid_id_exception.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoviesService {
  MoviesService({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  static const int _ageRestriction = 18;

  Future<List<Movie>> getMovies(UserDetail userDetail) async {
    final movies = await _movieRepository.getMovies();
    if (movies.isEmpty) {
      throw NoDataMovieException();
    }

    final ageValidation = userDetail.age >= _ageRestriction;
    if (ageValidation) {
      return movies;
    } else {
      return movies.where((movie) => movie.adult == ageValidation).toList();
    }
  }

  Future<Movie?> getMovie(int id) async {
    return id >= 0 ? _movieRepository.getMovie(id) : throw InvalidIdException();
  }
}
