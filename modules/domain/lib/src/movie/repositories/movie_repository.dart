import 'package:domain/domain.dart';

abstract class MovieRepository {
  Future<Movie?> getMovie(int id);
  Future<List<Movie>> getMovies();
}
