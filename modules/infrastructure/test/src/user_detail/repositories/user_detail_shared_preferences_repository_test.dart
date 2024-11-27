import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/src/shared/exceptions/no_data_found.dart';
import 'package:infrastructure/src/user_detail/repositories/user_detail_shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    final values = <String, Object>{};
    SharedPreferences.setMockInitialValues(values);
  });
  group('saveAge-getAge', () {
    late UserDetailRepository userSharedPreferencesRepository;

    setUp(() {
      userSharedPreferencesRepository = AgeSharedPreferencesRepository();
    });

    test('> get age in shared preferences when not are data > get NotDataFoundException', () async {
      //Act - Assert
      expect(
        () => userSharedPreferencesRepository.getAge(),
        throwsA(isA<NotDataFoundException>().having((e) => e.toString(), 'message', contains('No data found'))),
      );
    });

    test('> save age in shared preferences > get correct age from shared preferences', () async {
      //Arrange
      const userAge = 37;

      //Act
      await userSharedPreferencesRepository.saveAge(userAge);
      final ageFromSharedPreferences = await userSharedPreferencesRepository.getAge();

      //Assert
      expect(ageFromSharedPreferences, userAge);
    });
  });
}
