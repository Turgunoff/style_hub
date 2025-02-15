import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  final currentPage = 0.obs;

  void onPageChanged(int page) {
    currentPage.value = page;
  }
}
