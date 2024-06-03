import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                Obx(() {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: accountController.profileImagePath.value ==
                            'assets/profile.png'
                        ? AssetImage(accountController.profileImagePath.value)
                        : FileImage(
                                File(accountController.profileImagePath.value))
                            as ImageProvider,
                  );
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        accountController.setProfileImagePath(pickedFile.path);
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
              width: 350, // 너비 조절
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
                  hintText: " 이름을 입력해주세요.",
                  labelStyle: const TextStyle(
                    fontFamily: "SF-Pro-Rounded",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                // 보내기 버튼을 눌렀을 때의 로직
                // 저장하기 버튼을 누르면 my.dart 페이지로 이동
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    child: TextButton(
                      onPressed: () {
                        // 비밀번호 변경 페이지로 이동하는 로직 추가
                      },
                      child: Text(
                        "비밀번호 변경하기",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Rounded",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    child: TextButton(
                      onPressed: () {
                        // 계정 탈퇴 로직 추가
                      },
                      child: Text(
                        "계정 탈퇴",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Rounded",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountController extends GetxController {
  var userName = '허찬'.obs;
  var profileImagePath = 'assets/profile.png'.obs;
  var isExpanded = false.obs; // isExpanded 상태 추가
  void setUserName(String name) {
    userName.value = name.isEmpty ? '사용자' : name;
  }

  void setProfileImagePath(String path) {
    profileImagePath.value = path;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
