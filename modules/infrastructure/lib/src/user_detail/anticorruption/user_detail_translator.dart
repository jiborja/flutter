import 'package:domain/domain.dart';

class UserDetailTranslator {
  static UserDetail fromSharedPreferencesToDomain(int age) => UserDetail(age: age);
}
