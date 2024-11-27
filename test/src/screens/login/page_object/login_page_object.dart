import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/screens/login/widgets/login_form.dart';

class LoginPageObject {
  LoginPageObject({required WidgetTester tester}) : _tester = tester;

  final _emailTextField = find.byKey(LoginForm.emailTextFieldKey);
  final _passwordTextField = find.byKey(LoginForm.passwordTextFieldKey);
  final _loginButton = find.byKey(LoginForm.loginButtonKey);

  final WidgetTester _tester;

  Future<void> setEmail(String email) async => _tester.enterText(_emailTextField, email);
  Future<void> setPassword(String password) async => _tester.enterText(_passwordTextField, password);

  Future<void> tapLoginButton() async {
    await _tester.tap(_loginButton);
    await _tester.pumpAndSettle();
  }
}
