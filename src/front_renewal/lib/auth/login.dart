import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_renewal/auth/signup.dart';
import 'package:front_renewal/display/app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // 로그인 성공 시 처리
      Get.snackbar("성공", "로그인 성공");
      Get.offAll(() => const App());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("에러", "사용자를 찾을 수 없습니다.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("에러", "잘못된 비밀번호입니다.");
      } else {
        Get.snackbar("에러", "로그인에 실패했습니다.");
      }
    } catch (e) {
      Get.snackbar("에러", "로그인 중 문제가 발생했습니다.");
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 175),
            Row(
              children: [
                const SizedBox(width: 100),
                Container(
                  child: Image.asset(
                    'assets/fill_up_logo.png',
                    width: 53,
                    height: 51,
                    fit: BoxFit.fill,
                  ),
                ),
                const Text(
                  "Fill UP",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffC4C3C3),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff004fff),
                        ),
                      ),
                      hintText: " 이메일을 입력해주세요.",
                      labelStyle: TextStyle(
                        fontFamily: "SF-Pro-Rounded",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordView,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffC4C3C3),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff004fff),
                        ),
                      ),
                      hintText: " 비밀번호를 입력해주세요.",
                      labelStyle: const TextStyle(
                        fontFamily: "SF-Pro-Rounded",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "비밀번호를 잊으셨나요? ",
                        style: TextStyle(
                          fontFamily: "SF-PRO-Rounded",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff606060),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0b44f4),
                      minimumSize: const Size(353, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                        color: Color(0xFFffffff),
                        fontFamily: "SF-Pro-Rounded",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              child: Image.asset('assets/simple_login_info.png'),
            ),
            SizedBox(
              width: 353,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromRGBO(107, 107, 109, 0.3),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/naver_icon.svg',
                  width: 35,
                  height: 35,
                ),
                label: const Text(
                  "네이버 로그인",
                  style: TextStyle(
                    color: Color(0xff6b6b6d),
                    fontFamily: "SF-Pro-Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 353,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromRGBO(107, 107, 109, 0.3),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/google_icon.svg',
                  width: 35,
                  height: 35,
                ),
                label: const Text(
                  "구글  로그인",
                  style: TextStyle(
                    color: Color(0xff6b6b6d),
                    fontFamily: "SF-Pro-Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(const SignUp());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "아직 계정이 없나요?",
                    style: TextStyle(
                      fontFamily: "SF-Pro-Rounded",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff747474),
                    ),
                  ),
                  Text(
                    "  회원가입",
                    style: TextStyle(
                      fontFamily: "SF-Pro-Rounded",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0b44f4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
