import 'package:get/get.dart';
import 'dart:async';

class AppContlloer extends GetxService {
  static AppContlloer get to => Get.find();
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
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      Future.microtask(() => updateElapsedTime());
    });
  }

  void updateElapsedTime() {
    elapsedTime.value = DateTime.now().difference(startTime);
  }
}
