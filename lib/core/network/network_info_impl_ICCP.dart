import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'network_info.dart';

class NetworkInfoImplICCP implements NetworkInfo {
  final InternetConnection _connectionChecker;

  NetworkInfoImplICCP(this._connectionChecker);
  
  @override
  Future<bool> get isConnected => _connectionChecker.hasInternetAccess;
}
