import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends GetxService {
  final _connectivity = Connectivity();
  final isConnected = true.obs;

  Future<ConnectivityService> init() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return this;
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final wasConnected = isConnected.value;
    isConnected.value = result != ConnectivityResult.none;

    if (wasConnected && !isConnected.value) {
      Get.snackbar('Ogohlantirish', 'Internet aloqasi uzildi');
    }
  }
}
