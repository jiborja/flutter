import 'package:domain/src/auth/exceptions/invalid_email_exception.dart';
import 'package:domain/src/auth/exceptions/invalid_password_format_exception.dart';
import 'package:domain/src/auth/model/login.dart';
import 'package:domain/src/shared/exceptions/empty_param_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  group('Login', () {
    test('> create login with empty email > throws EmptyParamException', () {
      // Arrange
      const email = '';
      const password = 'password';

      // Act - Assert
      expect(
        () => Login(email: email, password: password),
        throwsA(isA<EmptyParamException>().having((e) => e.toString(), 'message', contains('cannot be empty'))),
      );
    });

    test('> create login with wrong email > throws InvalidEmailException', () {
      // Arrange
      const email = 'wrong-email';
      const password = 'password';

      // Act - Assert
      expect(
        () => Login(email: email, password: password),
        throwsA(isA<InvalidEmailException>().having((e) => e.toString(), 'message', contains('Please enter a valid email'))),
      );
    });

    test('> create login with empty password > throws EmptyParamException', () {
      // Arrange
      const email = 'email@test.com';
      const password = '';

      // Act - Assert
      expect(
        () => Login(email: email, password: password),
        throwsA(isA<EmptyParamException>().having((e) => e.toString(), 'message', contains('cannot be empty'))),
      );
    });

    test('> create login with wrong password > throws InvalidPasswordFormatException', () {
      // Arrange
      const email = 'email@test.com';
      const password = '123456';

      // Act - Assert
      expect(
        () => Login(email: email, password: password),
        throwsA(isA<InvalidPasswordFormatException>()),
      );
    });

    test('> create login with valid email and password > creates instance of Login', () {
      // Arrange
      const email = 'email@test.com';
      const password = 'a12A34#56';

      // Act
      final login = Login(email: email, password: password);

      // Assert
      expect(
        login,
        isA<Login>().having((e) => e.email, 'Login email', equals(email)).having((e) => e.password, 'Login password', equals(password)),
      );
    });
  });
}
