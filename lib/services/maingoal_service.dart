import 'package:cloud_firestore/cloud_firestore.dart';

class MainGoalService {
  static final CollectionReference _mainGoalsCollection =
      FirebaseFirestore.instance.collection('main_goals');

  static Future<void> createMainGoal(Map<String, dynamic> data) async {
    await _mainGoalsCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readMainGoal(String id) async {
    DocumentSnapshot snapshot = await _mainGoalsCollection.doc(id).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateMainGoal(
      String id, Map<String, dynamic> data) async {
    await _mainGoalsCollection.doc(id).update(data);
  }

  static Future<void> deleteMainGoal(String id) async {
    await _mainGoalsCollection.doc(id).delete();
  }
}
