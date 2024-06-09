import 'package:get/get.dart';
import 'package:front_renewal/controller/timer_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front_renewal/model/store.dart';

class AccountController extends GetxController {
  var userName = '사용자'.obs;
  var profileImagePath = 'assets/profile.png'.obs;
  var isExpanded = false.obs;
  var isImagePickerActive = false.obs;
  var weeklyWatchTime = <TimeSlot>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadWatchTimes();
  }

  void setUserName(String name) {
    userName.value = name.isEmpty ? '사용자' : name;
  }

  void setProfileImagePath(String path) {
    profileImagePath.value = path;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> saveUserData(String name) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.email).set({
          'name': name,
          'profileImagePath': profileImagePath.value,
        });
        Get.snackbar("성공", "데이터가 성공적으로 저장되었습니다.");
      } catch (e) {
        Get.snackbar("오류", "데이터 저장 중 오류가 발생했습니다.");
      }
    }
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.email).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData =
            userDoc.data() as Map<String, dynamic>;
        userName.value = userData['name'];
        profileImagePath.value = userData['profileImagePath'];
      } else {
        await _firestoreService.initializeUserData(user);
        await loadUserData();
      }
    }
  }

  Future<void> saveWatchTime(DateTime date, Duration watchTime) async {
    await _firestoreService.saveWatchTime(date, watchTime);
  }

  Future<void> loadWatchTimes() async {
    var watchTimes = await _firestoreService.getRecentWatchTimes();
    weeklyWatchTime.value = watchTimes.entries.map((entry) {
      return TimeSlot(entry.key, entry.value);
    }).toList();
  }

  Future<void> deleteUserData(String email) async {
    // 사용자 문서 삭제
    await _firestore.collection('users').doc(email).delete();

    // watch_time 컬렉션의 모든 문서 삭제
    QuerySnapshot watchTimesSnapshot = await _firestore
        .collection('users')
        .doc(email)
        .collection('watch_time')
        .get();

    for (QueryDocumentSnapshot doc in watchTimesSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}