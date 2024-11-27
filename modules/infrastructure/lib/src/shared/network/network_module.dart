import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class NetworkModule {
  @LazySingleton()
  InternetConnectionChecker internetConnectionChecker() =>
      InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 1),
        checkInterval: const Duration(seconds: 1),
      );
}
