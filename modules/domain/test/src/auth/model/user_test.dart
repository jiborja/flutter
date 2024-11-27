import 'package:domain/domain.dart';
import 'package:domain/src/shared/exceptions/empty_param_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  group('User', () {
    test('> create user with empty email > throws EmptyParamException', () {
      // Arrange
      const email = '';

      // Act - Assert
      expect(
        () => User(email: email, username: ''),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create event with valid email > creates instance of User', () {
      // Arrange
      const email = 'email@test.com';

      // Act
      final user = User(email: email, username: 'pedrito');

      // Assert
      expect(
        user,
        isA<User>().having((e) => e.email, 'User email', equals(email)),
      );
    });
  });
}
