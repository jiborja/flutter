import 'package:domain/src/shared/argument_validator.dart';

class Register {
  Register({required this.username, required this.email, required this.password}) {
    ArgumentValidator.validateUsername(username);
    ArgumentValidator.validateEmail(email);
    ArgumentValidator.validatePassword(password);
  }

  final String username;
  final String email;
  final String password;
}
