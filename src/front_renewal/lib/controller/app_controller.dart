import 'package:get/get.dart';

class AppContlloer extends GetxService {
  static AppContlloer get to => Get.find();
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }
}
