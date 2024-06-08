import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 시청 시간 Firestore에 저장하는 용도입니다.

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWatchTime(DateTime date, Duration watchTime) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      await _firestore.collection('users').doc(user.email).collection('watch_time').doc(formattedDate).set({
        'watchTime': watchTime.inMinutes,
      });
    }
  }

  Future<Map<DateTime, Duration>> getRecentWatchTimes() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await _firestore.collection('users').doc(user.email).collection('watch_time')
        .orderBy('date', descending: true)
        .limit(5)
        .get();
      Map<DateTime, Duration> watchTimes = {};
      for (var doc in querySnapshot.docs) {
        String dateStr = doc.id;
        int watchTimeInMinutes = doc['watchTime'];
        DateTime date = DateTime.parse(dateStr);
        watchTimes[date] = Duration(minutes: watchTimeInMinutes);
      }
      return watchTimes;
    }
    return {};
  }
}
