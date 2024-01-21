import 'package:cloud_firestore/cloud_firestore.dart';

class SubGoalService {
  static final CollectionReference _subGoalsCollection =
      FirebaseFirestore.instance.collection('sub_goals');

  static Future<void> createSubGoal(Map<String, dynamic> data) async {
    await _subGoalsCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readSubGoal(int id) async {
    DocumentSnapshot snapshot =
        await _subGoalsCollection.doc(id.toString()).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateSubGoal(int id, Map<String, dynamic> data) async {
    await _subGoalsCollection.doc(id.toString()).update(data);
  }

  static Future<void> deleteSubGoal(int id) async {
    await _subGoalsCollection.doc(id.toString()).delete();
  }
}
