import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:front_renewal/auth/login.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          // 뒤로가기 버튼
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          // 회원가입 문구
          "회원가입",
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        shape: const Border(
          // 상단 안내바 구획선
          bottom: BorderSide(color: Color(0xffd2dbdd), width: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: TextFormField(
                        //아이디 입력창
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xff979797),
                          ),
                          enabledBorder: OutlineInputBorder(
                            // default 입력창
                            borderSide: const BorderSide(
                              color: Color(0xffC4C3C3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //클릭했을 때 입력창
                            borderSide: const BorderSide(
                              color: Color.fromARGB(153, 0, 81, 255),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: " 이메일을 입력해주세요.",
                          labelStyle: const TextStyle(
                            fontFamily: "SF-Pro-Rounded",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: TextFormField(
                        //비밀번호 입력창
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xff979797),
                          ),
                          enabledBorder: OutlineInputBorder(
                            // default 입력창
                            borderSide: const BorderSide(
                              color: Color(0xffC4C3C3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //클릭했을 때 입력창
                            borderSide: const BorderSide(
                              color: Color.fromARGB(153, 0, 81, 255),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: " 비밀번호를 입력해주세요.",
                          labelStyle: const TextStyle(
                            fontFamily: "SF-Pro-Rounded",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    // 로그인 버튼
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0b44f4),
                      minimumSize: const Size(353, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "보내기",
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontFamily: "SF-Pro-Rounded",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
