import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/screens/register/register_form.dart';

class RegisterPageObject {
  RegisterPageObject({required WidgetTester tester}) : _tester = tester;

  final _usernameTextField = find.byKey(RegisterForm.usernameTextFieldKey);
  final _emailTextField = find.byKey(RegisterForm.emailTextFieldKey);
  final _passwordTextField = find.byKey(RegisterForm.passwordTextFieldKey);
  final _saveButton = find.byKey(RegisterForm.saveButtonKey);

  final WidgetTester _tester;

  Future<void> setUsername(String username) async => _tester.enterText(_usernameTextField, username);
  Future<void> setEmail(String email) async => _tester.enterText(_emailTextField, email);
  Future<void> setPassword(String password) async => _tester.enterText(_passwordTextField, password);

  Future<void> tapSaveButton() async {
    await _tester.tap(_saveButton);
    await _tester.pumpAndSettle();
  }
}
