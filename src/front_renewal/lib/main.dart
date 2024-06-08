import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:front_renewal/auth/login.dart';
import 'package:front_renewal/auth/signup.dart';
import 'package:front_renewal/binding/init_binding.dart';
import 'package:front_renewal/controller/app_controller.dart';
// import 'package:front_renewal/controller/detail_controller.dart';
// import 'package:front_renewal/controller/home_controller.dart';
import 'package:front_renewal/display/app.dart';
import 'package:front_renewal/display/pages/datail.dart';
import 'package:front_renewal/display/pages/search.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(TimerController()); // 타이머 컨트롤러 초기화
  runApp(const FillUp());
}

class FillUp extends StatelessWidget {
  const FillUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: InitialBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/search', page: () => const Search()),
        GetPage(
          name: '/detail/:videoId',
          page: () => const Detail(),
          binding: BindingsBuilder(
            () {
              Get.put(YoutubePlayerController(
                  initialVideoId: Get.parameters["videoId"] as String));
            },
          ),
        ),
      ],
    );
  }
}
