import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infrastructure/src/shared/secure_storage/secure_repository.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: SecureRepository)
class SecureStorageRepository extends SecureRepository {
  SecureStorageRepository({required FlutterSecureStorage storage}) : _storage = storage;

  final FlutterSecureStorage _storage;

  @override
  Future<void> addItem(String key, String value) async => _storage.write(key: key, value: value);

  @override
  Future<String?> getItem(String key) async => _storage.read(key: key);
}
