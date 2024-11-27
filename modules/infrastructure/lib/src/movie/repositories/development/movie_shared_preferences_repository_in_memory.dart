import 'package:infrastructure/src/movie/repositories/contracts/movie_temporal_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: MovieTemporalRepository, env: [Environment.dev])
class MovieSharedPreferencesRepositoryInMemory
    implements MovieTemporalRepository {
  MovieSharedPreferencesRepositoryInMemory() {
    preference = '';
  }
  late String preference;
  @override
  Future<String> getLastUpdatedPreference() async => preference;

  @override
  Future<void> saveLastUpdatedPreference(String lastUpdated) async =>
      preference = lastUpdated;
}
