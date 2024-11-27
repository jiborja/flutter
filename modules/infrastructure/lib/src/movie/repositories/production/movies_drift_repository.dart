import 'package:domain/domain.dart';
import 'package:infrastructure/src/movie/anticorruption/movie_translator.dart';
import 'package:infrastructure/src/movie/persistence/dao/movie_dao.dart';
import 'package:infrastructure/src/movie/repositories/contracts/movie_local_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MovieLocalRepository, env: [Environment.prod])
class MoviesDriftRepository implements MovieLocalRepository {
  MoviesDriftRepository(MovieDao movieDao) : _movieDao = movieDao;
  final MovieDao _movieDao;

  @override
  Future<int> getCountMovies() async => _movieDao.getCountMovies();

  @override
  Future<Movie?> getMovie(int id) async {
    final movie = await _movieDao.getMovieById(id);
    return movie != null ? MovieTranslator.fromDatabaseToDomain(movie) : null;
  }

  @override
  Future<List<Movie>> getMovies() async {
    final result = await _movieDao.getAllMovies();
    return result.isNotEmpty
        ? result.map(MovieTranslator.fromDatabaseToDomain).toList()
        : [];
  }

  @override
  Future<void> insertMovies(List<Movie> movies) async {
    await _movieDao.insertMovies(
      movies.map(MovieTranslator.fromDomainToDatabase).toList(),
    );
  }

  @override
  Future<bool> isEmpty() async => await _movieDao.getCountMovies() <= 0;

  @override
  Future<bool> movieExist(int id) async => _movieDao.movieExist(id);
}
