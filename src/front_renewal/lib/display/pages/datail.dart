import 'package:flutter/material.dart';
import 'package:front_renewal/controller/detail_controller.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<DetailController>();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: const SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
              ),
              Text(
                "data",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
