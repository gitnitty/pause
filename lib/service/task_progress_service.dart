import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pause/models/task_prgress/task_progress.dart';

import 'firebase_service.dart';

class TaskProgressService {
  static final CollectionReference _taskProgressCollection =
      FirebaseService.fireStore.collection('taskprogress');

  static Future<void> createTaskProgress(Map<String, dynamic> data) async {
    await _taskProgressCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readTaskProgress(String id) async {
    DocumentSnapshot snapshot = await _taskProgressCollection.doc(id).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateTaskProgress(
      String id, Map<String, dynamic> data) async {
    await _taskProgressCollection.doc(id).update(data);
  }

  static Future<void> deleteTaskProgress(String id) async {
    await _taskProgressCollection.doc(id).delete();
  }

  static Future<List<TaskProgress>> getTaskProgressList(
      int uid, int taskId) async {
    return [
      TaskProgress(
        uid: 1,
        taskId: 1,
        timestamp: DateTime.parse("2024-02-04T10:30:00"),
      ),
      TaskProgress(
          uid: 1, taskId: 3, timestamp: DateTime.parse("2024-02-04T10:10:00")),
    ]
        .where((goal) => goal.taskId == taskId)
        .where((goal) => goal.uid == uid)
        .toList();
  }
}
