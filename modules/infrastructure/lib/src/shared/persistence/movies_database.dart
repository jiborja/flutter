import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:infrastructure/src/movie/persistence/dao/movie_dao.dart';
import 'package:infrastructure/src/movie/persistence/entity/movie_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'movies_database.g.dart';

@DriftDatabase(
  tables: [MovieEntity],
  daos: [MovieDao],
)
@singleton
class MoviesDatabase extends _$MoviesDatabase {
  MoviesDatabase() : super(_openConnection());

  MoviesDatabase.withQueryEx(super.queryExecutor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db_movie_database.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
