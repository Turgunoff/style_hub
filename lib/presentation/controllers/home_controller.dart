//create home controller

import 'package:get/get.dart';

class HomeController extends GetxController {
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    update();
  }
}
