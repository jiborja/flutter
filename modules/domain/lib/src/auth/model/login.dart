import 'package:domain/src/shared/argument_validator.dart';

class Login {
  Login({required this.email, required this.password}) {
    ArgumentValidator.validateEmail(email);
    ArgumentValidator.validatePassword(password);
  }

  final String email;
  final String password;
}
