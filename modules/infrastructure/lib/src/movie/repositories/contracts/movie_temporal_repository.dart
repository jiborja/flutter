abstract class MovieTemporalRepository {
  Future<String> getLastUpdatedPreference();
  Future<void> saveLastUpdatedPreference(String lastUpdated);
}
