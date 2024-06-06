import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:front_renewal/controller/app_controller.dart';
import 'package:front_renewal/display/pages/account_my.dart'; // 계정 관리 페이지 추가
import 'package:front_renewal/auth/login.dart'; // 로그인 페이지 추가

class My extends StatelessWidget with WidgetsBindingObserver {
  const My({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerController timerController = Get.put(TimerController());
    final AccountController accountController = Get.put(AccountController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 정보',
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Color.fromARGB(255, 224, 224, 224),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // 스크롤 가능하게 설정
        child: Column(
          children: [
            // 계정 정보 섹션
            Obx(() {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      // 사용자 계정 이미지
                      children: [
                        Obx(() {
                          final imagePath =
                              accountController.profileImagePath.value;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: imagePath == 'assets/profile.png'
                                ? Image.asset(
                                    imagePath,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                          Icons.error); // 기본 아이콘으로 대체
                                    },
                                  )
                                : Image.file(
                                    File(imagePath),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                          Icons.error); // 기본 아이콘으로 대체
                                    },
                                  ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 35),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    return Text(
                                      ' ${accountController.userName.value}',
                                      style: const TextStyle(
                                        fontFamily: "pretendard",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    );
                                  }),
                                  GestureDetector(
                                    onTap: () {
                                      accountController.toggleExpanded();
                                    },
                                    child: Icon(
                                      accountController.isExpanded.value
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color:
                                          const Color.fromARGB(255, 90, 90, 90),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                '  chan0823kr@gmail.com',
                                style: TextStyle(
                                  fontFamily: "SF-Pro-Rounded",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff747474),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(const AccountManagementPage());
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
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
                    if (accountController.isExpanded.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0), // 오른쪽 여백 추가
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("계정에서 로그아웃",
                                          style: TextStyle(
                                            fontFamily: "SF-Pro-Rounded",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          )),
                                      content: const Text("정말 로그아웃 하시겠습니까?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.to(
                                                const Login()); // 로그인 페이지로 이동
                                          },
                                          child: const Text("예"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("아니오"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "계정에서 로그아웃",
                                style: TextStyle(
                                  fontFamily: "SF-Pro-Rounded",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
            const Divider(color: Color.fromARGB(255, 224, 224, 224)),
            // 실행 시간 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.schedule,
                      color: Color.fromARGB(255, 90, 90, 90),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' 시청 시간',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xE8707070)),
                        ),
                        Obx(() {
                          timerController.updateElapsedTime();
                          final elapsedTime = timerController.elapsedTime.value;
                          final minutes = (elapsedTime.inMinutes % 60); // 분
                          final seconds = (elapsedTime.inSeconds % 60); // 초
                          final isDoubleDigit = minutes >= 10 && seconds >= 10;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              ' $minutes h  $seconds min',
                              style: TextStyle(
                                height: 2.5,
                                fontFamily: "Pretendard-Black",
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: const Color.fromARGB(255, 9, 150, 245),
                                letterSpacing: isDoubleDigit
                                    ? -2.0
                                    : 0.0, // 두 자릿수일 때 간격 줄이기
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
            const Divider(color: Color.fromARGB(255, 224, 224, 224)),
            // 타임 슬롯 섹션
            const Padding(
              padding: EdgeInsets.all(16.0),
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
                          padding: EdgeInsets.symmetric(vertical: 8.0),
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
          ],
        ),
      ),
    );
  }
}
