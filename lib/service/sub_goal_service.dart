import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pause/models/sub_goal/sub_goal.dart';

import 'firebase_service.dart';

class SubGoalService {
  static final CollectionReference _subGoalCollection =
      FirebaseService.fireStore.collection('sub_goal');

  static Future<void> createSubGoal(Map<String, dynamic> data) async {
    await _subGoalCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readSubGoal(int id) async {
    DocumentSnapshot snapshot =
        await _subGoalCollection.doc(id.toString()).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateSubGoal(int id, Map<String, dynamic> data) async {
    await _subGoalCollection.doc(id.toString()).update(data);
  }

  static Future<void> deleteSubGoal(int id) async {
    await _subGoalCollection.doc(id.toString()).delete();
  }

  static Future<List<SubGoal>> getSubGoalList(int uid, int mainGoalId) async {
    return [
      SubGoal(
        id: 1,
        uid: 1,
        mainGoalId: 1,
        goal: "로스쿨 진학",
      ),
      SubGoal(
        id: 2,
        uid: 1,
        mainGoalId: 1,
        goal: "변호사 면허증",
      ),
      SubGoal(
        id: 3,
        uid: 1,
        mainGoalId: 2,
        goal: "중간고사 4.3 달성",
      ),
      SubGoal(
        id: 4,
        uid: 1,
        mainGoalId: 3,
        goal: "봉사 시간 150시간 달성하기",
      ),
    ]
        .where((goal) => goal.mainGoalId == mainGoalId)
        .where((goal) => goal.uid == uid)
        .toList();
  }
}
