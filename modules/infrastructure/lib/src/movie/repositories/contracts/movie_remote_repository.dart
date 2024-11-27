import 'package:domain/domain.dart';

mixin MovieRemoteRepository {
  Future<List<Movie>> getMovies();
}
