import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends GetxService {
  final _connectivity = Connectivity();

  Future<ConnectivityService> init() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return this;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    // Handle connectivity changes
  }
}
