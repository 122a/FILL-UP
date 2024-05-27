import 'package:front_renewal/controller/app_controller.dart';
import 'package:front_renewal/repository/youtube_repository.dart';
import 'package:get/get.dart';

enum RouteName { home, search, my }

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(YoutubeRepository(), permanent: true);
    Get.put(AppController());
  }
}
