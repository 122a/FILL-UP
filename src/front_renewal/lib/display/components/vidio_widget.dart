import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VidioWidget extends StatelessWidget {
  const VidioWidget({super.key});

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
    );
  }

  Widget _detailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 25),
      child: Row(
        children: [
          const CircleAvatar(
            // 유투브 채널 사진
            radius: 23,
            backgroundColor: Color(0xff004fff),
          ),
          const SizedBox(width: 12),
          Expanded(
            // 동영상 제목 조회수, 및 디테일 정보 및 설정 버튼
            child: Column(
              children: [
                Row(
                  //윗 줄
                  children: [
                    const Expanded(
                      child: Text(
                        "#4 반응형 웹디자인을 위한 최적화된 그리드 만들기(UI 입문이라면 꼭 봐야하는 영상)",
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ],
                ),
                const Row(
                  // 아랫줄
                  children: [
                    // 채널명
                    Text(
                      "디자인 베이스 • ",
                      style: TextStyle(fontSize: 13),
                    ),
                    //조회수
                    Text(
                      "조회수 9.7만회 • ",
                      style: TextStyle(fontSize: 13),
                    ),
                    // 올린 날짜
                    Text(
                      "4년 전",
                      style: TextStyle(fontSize: 13),
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
