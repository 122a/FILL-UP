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
            Stack(
              children: [
                Obx(() {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: accountController.profileImagePath.value == 'assets/profile.png'
                        ? AssetImage(accountController.profileImagePath.value)
                        : FileImage(File(accountController.profileImagePath.value)) as ImageProvider,
                  );
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
            SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: accountController.userName.value),
              onChanged: (value) {
                accountController.setUserName(value);
              },
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
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

  void setUserName(String name) {
    userName.value = name;
  }

  void setProfileImagePath(String path) {
    profileImagePath.value = path;
  }
}