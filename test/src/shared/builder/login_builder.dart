// ignore_for_file: avoid_returning_this

import 'package:domain/domain.dart' show Login;

class LoginBuilder {
  LoginBuilder() {
    _email = 'valid-email@unit.test';
    _password = 'a12A34#56';
  }

  late String _email;
  late String _password;

  LoginBuilder withEmail(String email) {
    _email = email;
    return this;
  }

  LoginBuilder withPassword(String password) {
    _password = password;
    return this;
  }

  Login build() => Login(
        email: _email,
        password: _password,
      );
}
