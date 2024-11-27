import 'package:domain/src/shared/argument_validator.dart';

class User {
  User({required this.email, required this.username}) {
    ArgumentValidator.validateEmail(email);
    ArgumentValidator.validateUsername(username);
  }

  final String email;
  final String username;
}
