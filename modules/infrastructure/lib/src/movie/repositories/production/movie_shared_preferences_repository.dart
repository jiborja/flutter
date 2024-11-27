import 'package:infrastructure/src/movie/repositories/contracts/movie_temporal_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefLastUpdate = 'LastUpdated';

@Injectable(as: MovieTemporalRepository, env: [Environment.prod])
class MovieSharedPreferencesRepository implements MovieTemporalRepository {
  @override
  Future<String> getLastUpdatedPreference() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefLastUpdate) ?? '';
  }

  @override
  Future<void> saveLastUpdatedPreference(String lastUpdated) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_prefLastUpdate, lastUpdated);
  }
}
