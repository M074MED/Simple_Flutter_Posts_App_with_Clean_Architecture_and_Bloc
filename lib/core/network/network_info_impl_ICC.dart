import 'network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfoImplICC implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImplICC(this._connectionChecker);
  
  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
