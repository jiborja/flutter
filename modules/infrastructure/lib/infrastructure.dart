library infrastructure;

import 'package:injectable/injectable.dart';

export 'package:infrastructure/src/movie/repositories/movie_proxy.dart';
export 'package:infrastructure/src/shared/exceptions/not_connected_to_network.dart'
    show NotConnectedToNetworkException;
export 'package:infrastructure/src/shared/exceptions/technical_exception.dart'
    show TechnicalException;
export 'package:infrastructure/src/shared/network/network_verify.dart' show NetworkVerify;

@InjectableInit.microPackage()
void initInfrastructure() {}
