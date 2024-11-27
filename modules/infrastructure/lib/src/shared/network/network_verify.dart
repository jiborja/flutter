import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@LazySingleton()
class NetworkVerify {
  const NetworkVerify(this._internetConnectionChecker);
  final InternetConnectionChecker _internetConnectionChecker;

  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

}
