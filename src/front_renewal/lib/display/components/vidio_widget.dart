import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_renewal/controller/video_controller.dart';
import 'package:front_renewal/model/video.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VidioWidget extends StatefulWidget {
  final Video video;
  const VidioWidget({super.key, required this.video});

  @override
  State<VidioWidget> createState() => _VidioWidgetState();
}

class _VidioWidgetState extends State<VidioWidget> {
  late VideoController _videoController;
  @override
  void initState() {
    _videoController = Get.put(VideoController(video: widget.video),
        tag: widget.video.id.videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _thumbnail(),
          _detailInfo(),
        ],
      ),
    );
  }

  Widget _thumbnail() {
    return Container(
      height: 210,
      color: const Color.fromARGB(52, 0, 81, 255),
      child: Image.network(
        widget.video.snippet.thumbnails.high.url,
        width: 411.3,
        height: 250,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _detailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: CircleAvatar(
              // 유투브 채널 사진
              radius: 19.5,
              backgroundColor: Color.fromARGB(255, 0, 81, 255),
              // 유투브 채널 사진
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            // 동영상 제목 조회수, 및 디테일 정보 및 설정 버튼
            child: Column(
              children: [
                Row(
                  //윗 줄
                  children: [
                    Expanded(
                      child: Text(
                        widget.video.snippet.title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ],
                ),
                Row(
                  // 아랫줄
                  children: [
                    // 채널명
                    Text(
                      "${widget.video.snippet.channelTitle} • ",
                      style: const TextStyle(fontSize: 13),
                    ),
                    //조회수
                    Obx(
                      () => Text(
                        "조회수 ${_videoController.statistics.value.viewCount}회 • ",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    // 올린 날짜
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(widget.video.snippet.publishedAt),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
