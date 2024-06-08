import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    Future<void> _changePassword(String newPassword, String confirmPassword, BuildContext context) async {
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.')),
        );
        return;
      }

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
          );
          Get.back(); // 비밀번호 변경 페이지로 이동
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사용자를 찾을 수 없습니다.')),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('비밀번호 변경에 실패했습니다. ${e.message}')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "비밀번호 변경",
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
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
                hintText: " 새로운 비밀번호",
                labelStyle: const TextStyle(
                  fontFamily: "SF-Pro-Rounded",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
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
                hintText: " 비밀번호 재확인",
                labelStyle: const TextStyle(
                  fontFamily: "SF-Pro-Rounded",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 460,
            ),
            ElevatedButton(
              onPressed: () {
                _changePassword(
                  newPasswordController.text.trim(),
                  confirmPasswordController.text.trim(),
                  context,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0b44f4),
                minimumSize: const Size(353, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "저장",
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
      ),
    );
  }
}
