import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  static final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  static Future<void> createTask(Map<String, dynamic> data) async {
    await _tasksCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readTask(String id) async {
    DocumentSnapshot snapshot = await _tasksCollection.doc(id).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await _tasksCollection.doc(id).update(data);
  }

  static Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }
}
