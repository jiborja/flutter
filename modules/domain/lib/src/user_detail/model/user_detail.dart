import 'package:domain/src/user_detail/exceptions/invalid_age_exception.dart';
import 'package:domain/src/user_detail/exceptions/out_of_range_age_exception.dart';

class UserDetail {
  UserDetail({required this.age}) {
    _validateAge();
  }

  static const _minAge = 5;
  static const _maxAge = 50;

  final int age;

  void _validateAge() {
    if (age <= 0) {
      throw InvalidAgeException();
    } else if (age < _minAge || age > _maxAge) {
      throw OutOfRangeAgeException();
    }
  }
}
