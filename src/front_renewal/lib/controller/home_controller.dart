import 'package:front_renewal/model/youtube_vidio_result.dart';
import 'package:front_renewal/repository/youtube_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult().obs;

  @override
  void onInit() {
    _videoLoad();
    super.onInit();
  }

  void _videoLoad() async {
    YoutubeVideoResult youtubeVideoResult =
        await YoutubeRepository.to.loadVideo();

    if (youtubeVideoResult.items != null &&
        youtubeVideoResult.items!.isNotEmpty) {
      youtubeResult(youtubeVideoResult);
    }
  }
}
