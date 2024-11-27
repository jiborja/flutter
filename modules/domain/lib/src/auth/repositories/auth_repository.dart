import 'package:domain/src/auth/model/login.dart';
import 'package:domain/src/auth/model/register.dart';
import 'package:domain/src/auth/model/user.dart';

abstract class AuthRepository {
  Stream<User?> get authState;
  Future<void> logInWithEmailAndPassword(Login login);
  Future<void> registerWithEmailAndPassword(Register register);
  Future<void> logOut();
  Future<String> getToken();
}
