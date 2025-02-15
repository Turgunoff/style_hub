//create home controller

import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedCategoryIndex = 0.obs; // RxInt tipidagi observable
  final categories = <String>[].obs; // RxList tipidagi observable

  @override
  void onInit() {
    super.onInit();
    // Kategoriyalarni yuklash
    loadCategories();
  }

  void loadCategories() {
    categories.value = [
      'All',
      'Haircut',
      'Shaving',
      'Facial',
      'Hair Color',
      'Massage',
    ];
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
  }
}
