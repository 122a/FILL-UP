import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class TimeSlot {
  final DateTime date;
  final Duration watchTime;

  TimeSlot(this.date, this.watchTime);
}

class TimerController extends GetxController {
  var startTime = DateTime.now();
  var elapsedTime = Rx<Duration>(Duration(seconds: 0));
  late Timer _timer;
  var dailyWatchTime = <String, Duration>{}.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String userId;

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.email!;
      await _loadStartTime();
      await _loadDailyWatchTime();
      startTimer();
    } else {
      // Handle unauthenticated user scenario
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
    _saveStartTime();
    _saveDailyWatchTime();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (_) { // 매 분마다 호출하도록 변경
      updateElapsedTime();
    });
  }

  void updateElapsedTime() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      elapsedTime.value = DateTime.now().difference(startTime);
      _updateDailyWatchTime();
    });
  }

  void _updateDailyWatchTime() {
    String today = formatDate(DateTime.now());
    dailyWatchTime[today] = elapsedTime.value;
    _saveDailyWatchTime();
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

  Future<void> _saveDailyWatchTime() async {
    Map<String, int> watchTimeMap = dailyWatchTime.map((key, value) => MapEntry(key, value.inSeconds));

    for (var entry in watchTimeMap.entries) {
      try {
        await _firestore.collection('users').doc(userId).collection('watch_time').doc(entry.key).set({
          'watch_time': entry.value,
        });
      } catch (e) {
        // Firestore 저장 실패 시 오류 처리
        print('Failed to save watch time for ${entry.key}: $e');
      }
    }
  }

  Future<void> _loadDailyWatchTime() async {
    QuerySnapshot snapshot = await _firestore.collection('users').doc(userId).collection('watch_time').get();
    Map<String, Duration> loadedWatchTime = {};

    for (var doc in snapshot.docs) {
      loadedWatchTime[doc.id] = Duration(seconds: doc['watch_time']);
    }

    dailyWatchTime.value = loadedWatchTime;
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}