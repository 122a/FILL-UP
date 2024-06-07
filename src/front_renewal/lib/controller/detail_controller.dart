import 'package:front_renewal/controller/video_controller.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  @override
  void onInit() {
    print(Get.parameters["videoId"]);
    super.onInit();
  }
}
