import 'dart:developer';

import 'package:pause/services/firebase_service.dart';

class TestService {
  static final TestService _instance = TestService._internal();

  factory TestService() => _instance;

  TestService._internal();

  static Future<bool> create(Map<String, dynamic> data) async {
    try {
      await FirebaseService.fireStore.collection("User").add(data);
      await FirebaseService.fireStore.collection("컬렉션").doc("id").set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> read(String id) async {
    try {
      final snapshot =
          await FirebaseService.fireStore.collection("컬렉션").doc(id).get();
      final snapshot2 = await FirebaseService.fireStore
          .collection("목표")
          .where("작성자", isEqualTo: "abc")
          .where("작성일", isLessThanOrEqualTo: "2024 1 17")
          .where("작성일", isGreaterThanOrEqualTo: "2024 1 16")
          .get();
      // backend http.get post("")
      String data = snapshot.get("field");
      Map<String, dynamic>? dataMap = snapshot.data();
      DateTime nowDate = DateTime.now();
      DateTime(nowDate.year,nowDate.month+1,1).difference(DateTime(nowDate.year,nowDate.month,1)).inDays;
      nowDate.add(Duration(days: 1));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> update(String id) async {
    try {
      // name : a -> b 로 바꿀때
      await FirebaseService.fireStore.collection("컬렉션").doc(id).update({
        "name": "b",
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> delete(String id) async {
    try {
      await FirebaseService.fireStore.collection("컬렉션").doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
