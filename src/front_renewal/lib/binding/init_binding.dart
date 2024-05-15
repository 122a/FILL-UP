import 'package:front_renewal/controller/app_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppContlloer());
  }
}
