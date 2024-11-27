import 'package:collection/collection.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_local_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: MovieLocalRepository, env: [Environment.dev])
class MoviesDriftRepositoryInMemory implements MovieLocalRepository {
  MoviesDriftRepositoryInMemory() : myMovies = <Movie>[];
  late final List<Movie> myMovies;
  @override
  Future<int> getCountMovies() async => myMovies.length;

  @override
  Future<void> insertMovies(List<Movie> movies) async =>
      myMovies.addAll(movies);

  @override
  Future<bool> isEmpty() async => myMovies.isEmpty;

  @override
  Future<bool> movieExist(int id) async =>
      myMovies.firstWhereOrNull((movie) => movie.id == id) != null;

  @override
  Future<Movie?> getMovie(int id) async =>
      myMovies.firstWhereOrNull((movie) => movie.id == id);

  @override
  Future<List<Movie>> getMovies() async => myMovies;
}
