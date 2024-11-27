import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/screens/user_detail/user_detail_form.dart';

class UserDetailPageObject {
  UserDetailPageObject({required WidgetTester tester}) : _tester = tester;

  final _ageTextField = find.byKey(UserDetailForm.ageTextFieldKey);
  final _saveButton = find.byKey(UserDetailForm.saveButtonKey);

  final WidgetTester _tester;

  Future<void> setAge(String age) async => _tester.enterText(_ageTextField, age);

  Future<void> tapSaveButton() async {
    await _tester.tap(_saveButton);
    await _tester.pumpAndSettle();
  }
}
