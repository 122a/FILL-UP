import 'package:front_renewal/model/video.dart';

class YoutubeVideoResult {
  int? totalResults;
  int? resultPerPage;
  String? nextPageToken;
  List<Video>? items;

  YoutubeVideoResult(
      {this.totalResults, this.resultPerPage, this.nextPageToken, this.items});

  factory YoutubeVideoResult.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoResult(
          totalResults: json["pageInfo"]["totalResults"],
          resultPerPage: json["pageInfo"]["resultPerPage"],
          nextPageToken: json["nextPageToken"] ?? "",
          items: List<Video>.from(
              json["items"].map((data) => Video.fromJson(data))));
}
