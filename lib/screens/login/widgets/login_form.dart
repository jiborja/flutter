import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/register/register_screen.dart';
import 'package:presentation/shared/decorations.dart';
import 'package:presentation/shared/theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  static const Key emailTextFieldKey = Key('email-textfield');
  static const Key passwordTextFieldKey = Key('password-textfield');
  static const Key loginButtonKey = Key('login-button');

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _textCrlEmail = TextEditingController();
  final _textCrlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context).login_screen_movies,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    key: LoginForm.emailTextFieldKey,
                    controller: _textCrlEmail,
                    decoration: MovieDecorations.buildInputDecoration(
                      AppLocalizations.of(context).login_screen_email,
                      Icons.email,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).login_screen_email_error_empty_input;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    key: LoginForm.passwordTextFieldKey,
                    obscureText: true,
                    controller: _textCrlPassword,
                    decoration: MovieDecorations.buildInputDecoration(
                      AppLocalizations.of(context).login_screen_password,
                      Icons.lock,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).login_screen_password_error_empty_input;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  key: LoginForm.loginButtonKey,
                  onPressed: () {
                    final bloc = context.read<LoginBloc>();

                    if (_formKey.currentState!.validate()) {
                      bloc.add(
                        LogIn(
                          email: _textCrlEmail.text,
                          password: _textCrlPassword.text,
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).login_screen_log_in,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Flexible(
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).login_screen_or,
                    ),
                    const Flexible(
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RegisterScreen.routeName,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).shared_sign_up,
                    style: const TextStyle(
                      color: MovieColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
