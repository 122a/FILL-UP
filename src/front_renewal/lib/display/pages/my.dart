import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:front_renewal/display/app.dart';
import 'package:front_renewal/controller/app_controller.dart';

class My extends StatelessWidget with WidgetsBindingObserver {
  const My({super.key});

 @override
  Widget build(BuildContext context) {
    final TimerController timerController = Get.put(TimerController());
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Color.fromARGB(255, 224, 224, 224),
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.to(const App());
          },
        ),
      ),
      body: Column(
        children: [
          // 계정 정보 섹션
          Expanded(
            flex: 2, // 20%
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset(
                      'assets/profile.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35),
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
                            ),
                          ],
                        ),
                        Text(
                          '  chan0822kr@gmail.com',
                          style: TextStyle(
                            fontFamily: "SF-Pro-Rounded",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              Get.to(const App());
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "내 계정 관리하기",
                              style: TextStyle(
                                fontFamily: "SF-Pro-Rounded",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff747474),
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
                    child: Icon(
                      Icons.schedule,
                      color: Color.fromARGB(255, 90, 90, 90),
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 시청 시간',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xE8707070)),
                        ),
                        Obx(() {
                          timerController.updateElapsedTime();
                          final elapsedTime = timerController.elapsedTime.value;
                          final minutes = (elapsedTime.inMinutes % 60); // 분
                          final seconds = (elapsedTime.inSeconds % 60); // 초
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '${seconds} h  ${minutes} min',
                              style: TextStyle(
                                height: 2.5,
                                fontFamily: "Pretendard-Black",
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 9, 150, 245),
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
                    child: Icon(
                      Icons.sort,
                      color: Color.fromARGB(255, 90, 90, 90),
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 타임 슬롯',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xE8707070)),
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
    );
  }
}
