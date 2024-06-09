import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_renewal/controller/timer_controller.dart';
import 'package:front_renewal/display/pages/account_my.dart'; 
import 'package:front_renewal/auth/login.dart';
import 'package:front_renewal/controller/account_controller.dart';
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
            color: Color(0xFFE0E0E0),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 계정 정보 섹션
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      // 사용자 계정 이미지
                      children: [
                        Obx(() {
                          final imagePath = accountController.profileImagePath.value;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: imagePath == 'assets/profile.png'
                                ? Image.asset(
                                    imagePath,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error); // 기본 아이콘으로 대체
                                    },
                                  )
                                : Image.file(
                                    File(imagePath),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error); // 기본 아이콘으로 대체
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      accountController.isExpanded.value ? Icons.expand_less : Icons.expand_more,
                                      color: const Color.fromARGB(255, 90, 90, 90),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '  ' + (FirebaseAuth.instance.currentUser?.email ?? ''),
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
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                            padding: const EdgeInsets.only(right: 30.0), // 오른쪽 여백 추가
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance.signOut();
                                  Get.to(const Login());
                                } catch (e) {
                                  Get.snackbar("오류", "로그아웃 중 오류가 발생했습니다.");
                                }
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
            const Divider(color: Color(0xFFE0E0E0)),
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
                          style: TextStyle(fontSize: 15, color: Color(0xE8707070)),
                        ),
                        Obx(() {
                          final elapsedTime = timerController.elapsedTime.value;
                          final minutes = elapsedTime.inHours; // 시간
                          final seconds = (elapsedTime.inMinutes % 60); // 분
                          final isDoubleDigit = minutes >= 10 && seconds >= 10;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              ' ${minutes} h  ${seconds} min',
                              style: TextStyle(
                                height: 2.5,
                                fontFamily: "Pretendard-Black",
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF0996F5),
                                letterSpacing: isDoubleDigit ? -2.0 : 0.0, // 두 자릿수일 때 간격 줄이기
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
            const Divider(color: Color(0xFFE0E0E0)),
            // 타임 슬롯 섹션
            Padding(
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
                          style: TextStyle(fontSize: 15, color: Color(0xE8707070)),
                        ),
                        SizedBox(height: 18),
                        Container(
                          height: 100, // 그래프의 높이 설정
                          alignment: Alignment.centerLeft, // 좌측 정렬 설정
                          padding: EdgeInsets.only(left: 0), // 좌측 여백 제거
                          child: Obx(() {
                            final dailyWatchTime = timerController.dailyWatchTime;
                            final today = DateTime.now();
                            final lastFiveDays = List.generate(5, (i) => today.subtract(Duration(days: i)))
                                .map((date) => TimeSlot(date, dailyWatchTime[timerController.formatDate(date)] ?? Duration.zero))
                                .toList();
                            lastFiveDays.sort((a, b) => a.date.compareTo(b.date));
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastFiveDays.length,
                              itemBuilder: (context, index) {
                                final timeSlot = lastFiveDays[index];
                                final ratio = (timeSlot.watchTime.inHours + timeSlot.watchTime.inMinutes / 60) / 24.0;
                                final barHeight = ratio * 100; // 그래프의 높이 계산
                                return Container(
                                  width: 55, // 각 날짜의 너비 설정
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  color: Color.fromARGB(255, 0, 132, 255), // 각 날짜의 색상 설정
                                  height: barHeight,
                                  child: Center(
                                    child: Text(
                                      '${timeSlot.date.month}/${timeSlot.date.day}\n${timeSlot.watchTime.inHours}h ${timeSlot.watchTime.inMinutes % 60}m',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "SF-Pro-Rounded",
                                          color: Colors.white), // 흰색으로 설정
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
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