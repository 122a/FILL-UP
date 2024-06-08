import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:front_renewal/controller/home_controller.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: SizedBox(
          height: 40,
          width: 300,
          child: Center(
            child: TextFormField(
              onFieldSubmitted: (value) {
                HomeController.to.searchVideos(value);
                Get.back(); // 검색어 입력 후 홈 화면으로 돌아가기
              },
              cursorColor: Colors.grey,
              cursorHeight: 30,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(55, 196, 195, 195),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(0, 255, 255, 255),
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(0, 255, 255, 255),
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                hintText: " 검색어를 입력해주세요.",
                labelStyle: const TextStyle(
                  fontFamily: "SF-Pro-Rounded",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
