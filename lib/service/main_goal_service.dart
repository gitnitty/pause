import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pause/models/main_goal/main_goal.dart';
import 'package:pause/service/firebase_service.dart';

import '../constants/constants_color.dart';

class MainGoalService {
  static final CollectionReference _mainGoalCollection =
      FirebaseService.fireStore.collection('main_goal');

  static Future<void> createMainGoal(Map<String, dynamic> data) async {
    await _mainGoalCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readMainGoal(String id) async {
    DocumentSnapshot snapshot = await _mainGoalCollection.doc(id).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateMainGoal(
      String id, Map<String, dynamic> data) async {
    await _mainGoalCollection.doc(id).update(data);
  }

  static Future<void> deleteMainGoal(String id) async {
    await _mainGoalCollection.doc(id).delete();
  }

  static Future<List<MainGoal>> getMainGoalList(int uid) async {
    return [
      MainGoal(
          id: 1,
          uid: 1,
          selectColor: kPrimaryColor.value,
          backgroundColor: 0xFFFFECE4,
          finish: false,
          deadline: DateTime(2025, 1, 1).toString(),
          goal: "변호사 되기"),
      MainGoal(
          id: 2,
          uid: 1,
          selectColor: kTertiaryColor.value,
          backgroundColor: 0xFFEEEDFF,
          finish: false,
          deadline: DateTime(2025, 1, 1).toString(),
          goal: "학점 4.3 달성"),
      MainGoal(
          id: 3,
          uid: 1,
          selectColor: 0xFFCCBD8A,
          backgroundColor: 0xFFFFFBEE,
          finish: false,
          deadline: DateTime(2025, 1, 1).toString(),
          goal: "인성 바르게 하기"),
      MainGoal(
          id: 4,
          uid: 2,
          selectColor: kPrimaryColor.value,
          backgroundColor: 0xFFFFECE4,
          finish: false,
          deadline: DateTime(2025, 1, 1).toString(),
          goal: "의사 되기"),
      MainGoal(
          id: 5,
          uid: 2,
          selectColor: kPrimaryColor.value,
          backgroundColor: 0xFFFFECE4,
          finish: false,
          deadline: DateTime(2025, 1, 1).toString(),
          goal: "운동대회 나가기"),
    ].where((goal) => goal.uid == uid).toList();
  }
}
