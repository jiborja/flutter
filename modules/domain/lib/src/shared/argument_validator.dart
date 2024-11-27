import 'package:domain/src/auth/exceptions/invalid_email_exception.dart';
import 'package:domain/src/auth/exceptions/invalid_password_format_exception.dart';
import 'package:domain/src/auth/exceptions/invalid_username_exception.dart';
import 'package:domain/src/shared/exceptions/empty_param_exception.dart';

class ArgumentValidator {
  static void validateEmail(String email) {
    const emailRegEx =
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";
    if (email.isEmpty) throw EmptyParamException(param: 'email');
    if (!RegExp(emailRegEx).hasMatch(email)) throw InvalidEmailException();
  }

  static void validateUsername(String username) {
    const usernameRegEx = r'^[a-zA-Z]+$';

    if (!RegExp(usernameRegEx).hasMatch(username)) throw InvalidUsernameException();
  }

  static void validatePassword(String password) {
    const passwordRegEx = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$';

    if (password.isEmpty) throw EmptyParamException(param: 'password');
    if (!RegExp(passwordRegEx).hasMatch(password)) {
      throw InvalidPasswordFormatException();
    }
  }
}
