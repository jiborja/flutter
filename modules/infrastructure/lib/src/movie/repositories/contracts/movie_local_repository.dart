import 'package:domain/domain.dart';

abstract class MovieLocalRepository {
  Future<Movie?> getMovie(int id);
  Future<bool> isEmpty();
  Future<List<Movie>> getMovies();
  Future<bool> movieExist(int id);
  Future<int> getCountMovies();
  Future<void> insertMovies(List<Movie> movies);
}
