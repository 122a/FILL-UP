import 'dart:ui';
import 'package:front_renewal/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:front_renewal/main.dart';
import 'package:get/get.dart';

class Count extends StatelessWidget {
  final TimerController timerController = Get.put(TimerController());

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('실행 시간'), // 바 제목을 "실행 시간"으로 설정
        centerTitle: true, // 바 제목을 가운데로 정렬
      ),
      body: Center(
        child: Obx(() {
          timerController.updateElapsedTime(); // 실행 시간 갱신
          final elapsedTime = timerController.elapsedTime.value;
          return Text('실행 시간: ${elapsedTime.inSeconds} seconds');
        }),
      ),
    );
  }
}