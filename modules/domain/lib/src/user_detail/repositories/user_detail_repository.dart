abstract class UserDetailRepository {
  Future<int> getAge();
  Future<void> saveAge(int age);
}
