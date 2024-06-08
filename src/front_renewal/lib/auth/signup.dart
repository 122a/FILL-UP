import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:front_renewal/auth/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _signUp() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // 회원가입 성공 시 처리
      Get.snackbar("성공", "회원가입이 완료되었습니다.");
      Get.offAll(() => const Login());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("에러", "비밀번호가 너무 약합니다.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("에러", "이미 사용 중인 이메일입니다.");
      } else {
        Get.snackbar("에러", "회원가입에 실패했습니다.");
      }
    } catch (e) {
      Get.snackbar("에러", "회원가입 중 문제가 발생했습니다.");
    }
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(color: Color(0xffd2dbdd), width: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xff979797),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffC4C3C3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
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
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xff979797),
                            ),
                            onPressed: _togglePasswordView,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffC4C3C3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0b44f4),
                      minimumSize: const Size(353, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "회원가입",
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
