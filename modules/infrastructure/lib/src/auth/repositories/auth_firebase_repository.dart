import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:infrastructure/infrastructure.dart';
import 'package:infrastructure/src/auth/anticorruption/user_translator.dart';
import 'package:infrastructure/src/shared/network/network_verify.dart';
import 'package:infrastructure/src/shared/secure_storage/secure_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthFirebaseRepository implements AuthRepository {
  AuthFirebaseRepository({
    required firebase.FirebaseAuth firebaseAuth,
    required SecureRepository secureRepository,
    required NetworkVerify networkVerify,
  })  : _firebaseAuth = firebaseAuth,
        _secureRepository = secureRepository,
        _networkVerify = networkVerify;

  final firebase.FirebaseAuth _firebaseAuth;
  final SecureRepository _secureRepository;
  final NetworkVerify _networkVerify;

  static const String _tokenKey = 'token';
  static const String _tokenExpirationKey = 'token-expiration';

  @override
  Stream<User?> get authState =>
      _firebaseAuth.userChanges().map((user) => (user != null && user.displayName != null) ? AuthTranslator.fromFirebaseToDomain(user) : null);

  @override
  Future<void> logInWithEmailAndPassword(Login login) async {
    if (await _networkVerify.isConnected) {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );

      final tokenMetadata = await userCredential.user!.getIdTokenResult();

      await _saveToken(
        tokenMetadata.token!,
        tokenMetadata.expirationTime.toString(),
      );
    } else {
      throw NotConnectedToNetworkException();
    }
  }

  @override
  Future<void> logOut() async {
    await _networkVerify.isConnected ? await _firebaseAuth.signOut() : throw NotConnectedToNetworkException();
  }

  @override
  Future<void> registerWithEmailAndPassword(Register register) async {
    await _networkVerify.isConnected
        ? await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: register.email,
              password: register.password,
            )
            .then(
              (credentials) async => credentials.user!.updateDisplayName(register.username),
            )
        : throw NotConnectedToNetworkException();
  }

  @override
  Future<String> getToken() async {
    final secureStoredToken = await _secureRepository.getItem(_tokenKey) ?? '';
    final secureStoredTokenExpiration = await _secureRepository.getItem(_tokenExpirationKey) ?? '';

    final bool expired;

    if (secureStoredTokenExpiration.isNotEmpty) {
      expired = DateTime.parse(secureStoredTokenExpiration.replaceAll('.', ',')).isBefore(DateTime.now());
    } else {
      expired = true;
    }

    if (secureStoredToken.isEmpty || secureStoredTokenExpiration.isEmpty || expired) {
      final tokenMetadata = await _firebaseAuth.currentUser!.getIdTokenResult();
      final token = tokenMetadata.token!;
      final tokenExporationDate = tokenMetadata.expirationTime!;

      await _saveToken(token, tokenExporationDate.toString());

      return token;
    } else {
      return secureStoredToken;
    }
  }

  Future<void> _saveToken(String token, String tokenExporationDate) async {
    await _secureRepository.addItem(_tokenKey, token);
    await _secureRepository.addItem(_tokenExpirationKey, tokenExporationDate);
  }
}
