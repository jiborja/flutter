import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  FirebaseAuth firebaseAuth() => FirebaseAuth.instance;
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
}
