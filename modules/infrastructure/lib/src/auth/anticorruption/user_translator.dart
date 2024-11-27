import 'package:domain/domain.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

class AuthTranslator {
  static domain.User fromFirebaseToDomain(User firebaseUser) {
    return domain.User(
      email: firebaseUser.email!,
      username: firebaseUser.displayName!,
    );
  }
}
