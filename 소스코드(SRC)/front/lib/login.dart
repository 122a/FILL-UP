import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/main.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱에서 공통적으로 쓰이는 속성, 컬러들
      theme: ThemeData(
        // cursor 색상
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff004fff),
        ),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            //양 옆 공백 20px
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                //천장과 로고 사이의 여백
                height: 175,
              ),
              Row(
                children: [
                  const SizedBox(
                    //로고와 왼쪽 벽사이의 여백
                    width: 96,
                  ),
                  Container(
                    //로고
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
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                //로고와 입력창 사이의 여백
                height: 150,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      //아이디 입력창
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          // default 입력창
                          borderSide: BorderSide(
                            color: Color(0xffC4C3C3),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          //클릭했을 때 입력창
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
                    const SizedBox(
                      //아이디 비밀번호 입력창 사이의 여백
                      height: 10,
                    ),
                    TextFormField(
                      // 비밀번호 입력창
                      obscureText: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.lock_outline), // 비밀번호 아이콘
                        enabledBorder: UnderlineInputBorder(
                          // default 입력창
                          borderSide: BorderSide(
                            color: Color(0xffC4C3C3),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          //클릭했을 때 입력창
                          borderSide: BorderSide(
                            color: Color(0xff004fff),
                          ),
                        ),
                        hintText: " 비밀번호를 입력해주세요.",
                        labelStyle: TextStyle(
                          fontFamily: "SF-Pro-Rounded",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      // 입력창과 "비밀번호 잊으셨습니까" 안내 문구 사이의 여백
                      height: 16,
                    ),
                    const Row(
                      //"비밀번호 잊으셨나요?" 안내문구
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
                    const SizedBox(
                      // "비밀번호 잊으셨나요?" 안내문구와 로그인 버튼 사이의 여백
                      height: 16,
                    ),
                    ElevatedButton(
                      // 로그인 버튼
                      onPressed: () {},
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
              const SizedBox(
                // 로그인 버튼과 간편로그인 info 사이의 간격
                height: 12,
              ),
              Container(
                // 간편로그인 안내 information
                child: Image.asset('assets/simple_login_info.png'),
              ),
              SizedBox(
                //네이버 로그인 버튼
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
              const SizedBox(
                // 네이버 로그인 버튼과 구글 로그인 버튼 사이 여백
                height: 16,
              ),
              SizedBox(
                //구글 로그인 버튼
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
              const SizedBox(
                height: 20,
              ),
              TextButton(
                // 회원가입 페이지로 향하는 텍스트버튼
                onPressed: () => context.go('/details'),
                child: const Row(
                  // 회원가입 안내와 버튼
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "아직 계정이 없나요?",
                      style: TextStyle(
                        fontFamily: "SF-Pro-Rounded",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(
                          0xff747474,
                        ),
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
      ),
    );
  }
}
