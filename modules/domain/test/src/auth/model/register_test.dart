import 'package:domain/domain.dart';
import 'package:domain/src/auth/exceptions/invalid_email_exception.dart';
import 'package:domain/src/auth/exceptions/invalid_password_format_exception.dart';
import 'package:domain/src/auth/exceptions/invalid_username_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Register', () {
    test('> create register with invalid username format > throw InvalidUsernameException', () {
      //Arrange
      const username = 'a b c';
      const email = 'correo@correo.com';
      const password = 'Qwerty78#';

      //Act - Assert
      expect(
        () => Register(username: username, email: email, password: password),
        throwsA(isA<InvalidUsernameException>().having((e) => e.toString(), 'message', contains('Please enter a valid user name'))),
      );
    });
    test('> create register with invalid email format > throw InvalidEmailException', () {
      //Arrange
      const username = 'username';
      const email = 'correo-correo-com';
      const password = 'Qwerty78#';

      //Act - Assert
      expect(
        () => Register(username: username, email: email, password: password),
        throwsA(isA<InvalidEmailException>().having((e) => e.toString(), 'message', contains('Please enter a valid email'))),
      );
    });
    test('> create register with invalid password format > throw InvalidPasswordFormatException', () {
      //Arrange
      const username = 'username';
      const email = 'correo@correo.com';
      const password = 'weak';

      //Act - Assert
      expect(
        () => Register(username: username, email: email, password: password),
        throwsA(isA<InvalidPasswordFormatException>()
            .having((e) => e.toString(), 'message', contains('Password does not meet the minimum security requirements'))),
      );
    });
    test('> create register with valid data > valid Register instance', () {
      //Arrange
      const username = 'username';
      const email = 'correo@correo.com';
      const password = 'Qwerty78#';

      //Act - Assert
      expect(
        Register(username: username, email: email, password: password),
        isA<Register>(),
      );
    });
  });
}
