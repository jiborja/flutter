import 'package:drift/drift.dart';
import 'package:infrastructure/src/movie/persistence/entity/movie_entity.dart';
import 'package:infrastructure/src/shared/persistence/movies_database.dart';
import 'package:injectable/injectable.dart';

part 'movie_dao.g.dart';

@injectable
@DriftAccessor(tables: [MovieEntity])
class MovieDao extends DatabaseAccessor<MoviesDatabase> with _$MovieDaoMixin {
  MovieDao(super.db);

  Future<List<MovieEntityData>> getAllMovies() async {
    return transaction(() async {
      return (select(movieEntity)).get();
    });
  }

  Future<MovieEntityData?> getMovieById(int id) async {
    return transaction(() async {
      return (select(movieEntity)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
    });
  }

  Future<int> getCountMovies() async {
    final count = movieEntity.id.count();
    final query = selectOnly(movieEntity)..addColumns([count]);
    return (await query.map((row) => row.read(count)).getSingle())!;
  }

  Future<bool> movieExist(int id) async {
    final query = select(movieEntity)..where((t) => t.id.equals(id));
    final answer = await query.getSingleOrNull();
    return answer != null;
  }

  Future<void> insertMovies(List<MovieEntityCompanion> movies) async {
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(movieEntity, movies, mode: InsertMode.insertOrReplace);
      });
    });
  }
}
