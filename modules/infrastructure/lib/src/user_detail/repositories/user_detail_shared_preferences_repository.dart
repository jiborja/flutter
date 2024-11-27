import 'package:domain/domain.dart';
import 'package:infrastructure/src/shared/exceptions/no_data_found.dart';
import 'package:infrastructure/src/user_detail/anticorruption/user_detail_translator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: UserDetailRepository)
class AgeSharedPreferencesRepository extends UserDetailRepository {
  static const String _prefAge = 'AgeRestriction';

  @override
  Future<int> getAge() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getInt(_prefAge);
    if (age != null) {
      return UserDetailTranslator.fromSharedPreferencesToDomain(age).age;
    } else {
      throw NotDataFoundException();
    }
  }

  @override
  Future<void> saveAge(int age) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(_prefAge, age);
  }
}
