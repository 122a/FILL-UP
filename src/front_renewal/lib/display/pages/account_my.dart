import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_renewal/auth/login.dart';
import 'package:front_renewal/display/pages/change_pwd.dart';
import 'package:front_renewal/controller/account_controller.dart';

class AccountManagementPage extends StatelessWidget {
  const AccountManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.put(AccountController());
    final TextEditingController nameController =
        TextEditingController(text: accountController.userName.value);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '계정 관리',
          style: TextStyle(
            fontFamily: "SF-Pro-Display",
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: accountController
                                  .profileImagePath.value ==
                              'assets/profile.png'
                          ? AssetImage(accountController.profileImagePath.value)
                          : FileImage(File(
                                  accountController.profileImagePath.value))
                              as ImageProvider,
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (!accountController.isImagePickerActive.value) {
                          accountController.isImagePickerActive.value = true;
                          try {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              accountController
                                  .setProfileImagePath(pickedFile.path);
                            }
                          } catch (e) {
                          } finally {
                            accountController.isImagePickerActive.value = false;
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      accountController.setUserName("사용자");
                    } else {
                      accountController.setUserName(value);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: '이름',
                    border: OutlineInputBorder(),
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
                    hintText: " 이름을 입력해주세요.",
                    labelStyle: const TextStyle(
                      fontFamily: "SF-Pro-Rounded",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Color(0xFFE0E0E0)),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "비밀번호 변경하기",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Rounded",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0b44f4),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Color(0xFFE0E0E0)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("계정 탈퇴"),
                              content: Text("정말로 계정을 탈퇴하시겠습니까?"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      // 현재 사용자가 있는지 확인합니다.
                                      User? user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        // Firestore에서 사용자 문서 및 watch_time 컬렉션 삭제
                                        await accountController.deleteUserData(user.email!);
                                        // 계정을 탈퇴합니다.
                                        await user.delete();
                                        // 탈퇴 후 로그아웃 처리
                                        await FirebaseAuth.instance.signOut();
                                        // 탈퇴가 성공적으로 이루어졌으므로 다이얼로그 닫기
                                        Navigator.of(context).pop();
                                        // 사용자에게 탈퇴 성공 메시지를 표시합니다.
                                        Get.snackbar(
                                            "성공", "계정이 성공적으로 탈퇴되었습니다.");
                                        Get.offAll(() => const Login());
                                      }
                                    } catch (e) {
                                      // 계정 탈퇴 중에 오류가 발생한 경우 오류 메시지를 표시합니다.
                                      Get.snackbar("오류", "계정 탈퇴 중 오류가 발생했습니다.");
                                    }
                                  },
                                  child: Text("예"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // 다이얼로그 닫기
                                  },
                                  child: Text("아니오"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "계정 탈퇴",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Rounded",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xFFE0E0E0)),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () async {
                  await accountController.saveUserData(nameController.text);
                  Get.back();
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
      ),
    );
  }
}
