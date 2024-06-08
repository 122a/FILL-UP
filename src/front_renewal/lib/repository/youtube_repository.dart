import 'dart:convert';

import 'package:front_renewal/model/statistics.dart';
import 'package:front_renewal/model/youtube_vidio_result.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class YoutubeRepository extends GetConnect {
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "http://www.googleapis.com";
    super.onInit();
  }

  Future<YoutubeVideoResult> loadVideo([String query = "디자인 베이스"]) async {
    String url =
        "https://www.googleapis.com/youtube/v3/search/?part=snippet&maxResults=25&order=date&type=video&videoDefinition=high&videoDuration=medium&key=AIzaSyBTIgG9ebGijQZogj3A9Gimxjm1EwNXLq8&q=$query";

    final response = await get(
      Uri.parse(url),
    );
    final resPar = json.decode(response.body); // Json형식으로 디코드(파싱) 해준 다음 사용해야함.
    if (response.statusCode == 404 || response.statusCode == 400) {
      return Future.error(response.statusCode);
    } else {
      if (resPar["items"] != null && resPar["items"].length > 0) {
        return YoutubeVideoResult.fromJson(resPar);
      }
    }
    return YoutubeVideoResult(); // 아무 것도 없는 상태인데 이 코드 한 줄이 실행될 가능성 현저히 낮음.
  }

  Future<Statistics> getVideoInfo(String videoId) async {
    String url =
        "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBTIgG9ebGijQZogj3A9Gimxjm1EwNXLq8&part=statistics&id=$videoId";

    final response = await get(
      Uri.parse(url),
    );
    final resPar = json.decode(response.body); // Json형식으로 디코드(파싱) 해준 다음 사용해야함.
    if (response.statusCode == 404 || response.statusCode == 400) {
      return Future.error(response.statusCode);
    } else {
      if (resPar["items"] != null && resPar["items"].length > 0) {
        Map<String, dynamic> data = resPar["items"][0];
        return Statistics.fromJson(data["statistics"]);
      }
    }
    return Statistics(); // 아무 것도 없는 상태인데 이 코드 한 줄이 실행될 가능성 현저히 낮음.
  }
}
