import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:front_renewal/auth/login.dart';
import 'package:front_renewal/auth/signup.dart';
import 'package:front_renewal/timer/count.dart';
import 'package:front_renewal/binding/init_binding.dart';
import 'package:front_renewal/display/app.dart';
import 'package:get/get.dart';

void main() {
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
        GetPage(name: '/', page: () => Count()),
      ],
    );
  }
}
