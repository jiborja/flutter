import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/register/bloc/register_bloc.dart';
import 'package:presentation/shared/decorations.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  static const Key usernameTextFieldKey = Key('username-textfield');
  static const Key emailTextFieldKey = Key('email-textfield');
  static const Key passwordTextFieldKey = Key('password-textfield');
  static const Key saveButtonKey = Key('save-button');

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).shared_sign_up,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    key: RegisterForm.usernameTextFieldKey,
                    controller: _userNameController,
                    decoration: MovieDecorations.buildInputDecoration(
                      AppLocalizations.of(context).register_screen_username,
                      Icons.person,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).shared_error_empty_input;
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    key: RegisterForm.emailTextFieldKey,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: MovieDecorations.buildInputDecoration(
                      AppLocalizations.of(context).shared_email,
                      Icons.email,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).shared_error_empty_input;
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    key: RegisterForm.passwordTextFieldKey,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: MovieDecorations.buildInputDecoration(
                      AppLocalizations.of(context).shared_password,
                      Icons.lock,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).shared_error_empty_input;
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  key: RegisterForm.saveButtonKey,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterBloc>(context).add(
                        RegisterSubmmited(
                          _emailController.text,
                          _passwordController.text,
                          _userNameController.text,
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).register_screen_signup,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
