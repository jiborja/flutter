import 'package:drift/drift.dart';

class MovieEntity extends Table {
  IntColumn get id => integer()();
  TextColumn get originalLanguage => text()();
  TextColumn get overview => text()();
  TextColumn get posterPath => text()();
  TextColumn get releaseDate => text()();
  TextColumn get title => text()();
  RealColumn get voteAverage => real()();
  BoolColumn get adult => boolean()();
  @override
  Set<Column> get primaryKey => {id};
}
