import 'package:front_renewal/model/statistics.dart';
import 'package:front_renewal/model/video.dart';
import 'package:front_renewal/repository/youtube_repository.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  Video video;
  VideoController({required this.video});
  Rx<Statistics> statistics = Statistics().obs;
  @override
  Future<void> onInit() async {
    Statistics loadStatistics =
        await YoutubeRepository.to.getVideoInfo(video.id.videoId);
    statistics(loadStatistics);
    super.onInit();
  }
}
