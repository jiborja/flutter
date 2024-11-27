import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:presentation/shared/decorations.dart';

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key});

  static const Key ageTextFieldKey = Key('age-textfield');
  static const Key saveButtonKey = Key('save-button');

  @override
  State<UserDetailForm> createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserDetailBloc>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).user_detail_form_title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 30),
            TextFormField(
              key: UserDetailForm.ageTextFieldKey,
              controller: _ageController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your age';
                } else {
                  final age = int.tryParse(value);
                  if (age == null) {
                    return 'Please enter a valid number';
                  }
                }

                return null;
              },
              keyboardType: TextInputType.number,
              decoration: MovieDecorations.buildInputDecoration(
                AppLocalizations.of(context).user_detail_age_label,
                Icons.numbers,
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              key: UserDetailForm.saveButtonKey,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(UserDetailSubmited(int.parse(_ageController.text)));
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).user_detail_submit_button_label,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
