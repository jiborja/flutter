
abstract class SecureRepository {
  Future<void> addItem(String key, String value);
  Future<String?> getItem(String key);
}
