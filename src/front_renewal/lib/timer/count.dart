import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:front_renewal/display/app.dart';
import 'package:front_renewal/controller/app_controller.dart';

class Count extends StatelessWidget {
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 정보',
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          // 취소 버튼
          icon: Icon(Icons.close),
          onPressed: () {
            Get.to(const App());
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Color.fromARGB(255, 224, 224, 224),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // 계정 정보 섹션
          Expanded(
            flex: 2, // 20%
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 16.0), //좌우 패딩
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(25.0), // 원하는 모서리 둥글기 정도 설정
                    child: Image.asset(
                      'assets/profile.png',
                      width: 70,
                      height: 70,
                    ),
                  ), // 이미지 삽입
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35), // 텍스트 위에 5px의 공백 추가
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' 허찬',
                              style: TextStyle(
                                fontFamily: "pretendard",
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Icon(
                              Icons.expand_more,
                              color: Color.fromARGB(255, 90, 90, 90),
                            ), // Expand More 아이콘
                          ],
                        ),
                        Text(
                          '  chan0822kr@gmail.com', //사용자 계정(+)
                          style: TextStyle(
                            fontFamily: "SF-Pro-Rounded",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474),
                          ),
                        ),

                        SizedBox(height: 10), // 이메일 아래에 약간의 공백 추가
                        Align(
                          alignment: Alignment.centerLeft, // 좌측 정렬
                          child: TextButton(
                            // 계정관리로 가는 버튼
                            onPressed: () {
                              Get.to(
                                const App(),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              minimumSize: Size(0, 0), // 최소 크기 설정
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap, // 탭 영역 축소
                            ),
                            child: Text(
                              "내 계정 관리하기",
                              style: TextStyle(
                                fontFamily: "SF-Pro-Rounded",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(
                                  0xff747474,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(color: Color.fromARGB(255, 224, 224, 224)),
          // 실행 시간 섹션
          Expanded(
            flex: 3, // 35%
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(Icons.schedule,
                        color: Color.fromARGB(255, 90, 90, 90), size: 30),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 시청 시간',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xE8707070)),
                        ),
                        Obx(() {
                          timerController.updateElapsedTime();
                          final elapsedTime = timerController.elapsedTime.value;
                          final hours = elapsedTime.inHours;
                          final minutes = elapsedTime.inMinutes.remainder(60);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                '${hours} h  ${minutes} min',
                                style: TextStyle(
                                  height: 2.5,
                                  fontFamily: "Pretendard-Black",
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 9, 150, 245),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Color.fromARGB(255, 224, 224, 224)),
          // 타임 슬롯 섹션
          Expanded(
            flex: 4, // 45%
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(Icons.sort,
                        color: Color.fromARGB(255, 90, 90, 90), size: 30),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 타임 슬롯',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xE8707070)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '타임 슬롯 내용',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '탐색',
          ),
        ],
        currentIndex: 0, // 선택된 인덱스 (기본값 0으로 설정)
        selectedItemColor:
            // 하단 바 내의 요소를 클릭했을 때 나타나는 색을 지정해준 것
            const Color(0xff004fff),
        selectedFontSize: 12, // focused되고 있는 아이템의 글자 크기
        unselectedFontSize: 12, // unfocused 된 아이템의 글자 크기
        onTap: (index) {
          // 인덱스에 따른 동작 정의
          if (index == 0) {
            // 홈 버튼 클릭 시 동작
          } else if (index == 1) {
            // 탐색 버튼 클릭 시 동작
          }
        },
      ),
    );
  }
}
