import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AppController extends GetxService {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    currentIndex(index);
  }
}

class TimerController extends GetxController {
  var startTime = DateTime.now();
  var elapsedTime = Rx<Duration>(Duration(seconds: 0));
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _loadStartTime();
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
    _saveStartTime();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      updateElapsedTime();
    });
  }

  void updateElapsedTime() {
    elapsedTime.value = DateTime.now().difference(startTime);
  }

  Future<void> _saveStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('startTime', startTime.toIso8601String());
  }

  Future<void> _loadStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? startTimeStr = prefs.getString('startTime');
    if (startTimeStr != null) {
      startTime = DateTime.parse(startTimeStr);
    } else {
      startTime = DateTime.now();
      _saveStartTime();
    }
  }
}