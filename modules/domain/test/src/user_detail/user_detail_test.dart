import 'package:domain/domain.dart';
import 'package:domain/src/user_detail/exceptions/invalid_age_exception.dart';
import 'package:domain/src/user_detail/exceptions/out_of_range_age_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDetailRepository extends Mock implements UserDetailRepository {}

void main() {
  late UserDetail userDetail;
  setUp(() {
    userDetail = UserDetail(age: 25);

    registerFallbackValue(userDetail);
  });
  group('UserDetail', () {
    test('> create user detail with negative number > throws InvalidAgeException', () {
      //Arrange
      const age = -10;

      //Act - Assert
      expect(
        () => UserDetail(age: age),
        throwsA(isA<InvalidAgeException>().having((e) => e.toString(), 'message', contains('Please enter a valid age'))),
      );
    });

    test('> create user detail with big number > throws OutOfRangeAgeException', () {
      //Arrange
      const age = 1000;

      //Act - Assert
      expect(
        () => UserDetail(age: age),
        throwsA(isA<OutOfRangeAgeException>().having((e) => e.toString(), 'message', contains('Your age is out of range'))),
      );
    });

    test('> create user detail witn number zero > throws InvalidAgeException', () {
      //Arrange
      const age = 0;

      //Act - Assert
      expect(
        () => UserDetail(age: age),
        throwsA(isA<InvalidAgeException>().having((e) => e.toString(), 'message', contains('Please enter a valid age'))),
      );
    });

    test('> create user detail with valid number of age > valid instance of UserDetail', () {
      //Arrange
      const age = 20;

      //Act - Assert
      expect(UserDetail(age: age), isA<UserDetail>());
    });
  });
}
