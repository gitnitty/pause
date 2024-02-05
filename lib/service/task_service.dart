import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task/task.dart';
import 'firebase_service.dart';

class TaskService {
  static final CollectionReference _taskCollection =
      FirebaseService.fireStore.collection('task');

  static Future<void> createTask(Map<String, dynamic> data) async {
    await _taskCollection.add(data);
  }

  static Future<Map<String, dynamic>?> readTask(String id) async {
    DocumentSnapshot snapshot = await _taskCollection.doc(id).get();
    return snapshot.data() as Map<String, dynamic>?; // Explicit cast
  }

  static Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await _taskCollection.doc(id).update(data);
  }

  static Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }

  static Future<List<Task>> getTaskList(
      int uid, int mainGoalId, int subGoalId) async {
    return [
      Task(
          id: 1,
          uid: 1,
          mainGoalId: 1,
          subGoalId: 1,
          goal: "법률 기사 3개 읽기",
          repeatType: '',
          repeatValue: ''),
      Task(
          id: 2,
          uid: 1,
          mainGoalId: 1,
          subGoalId: 1,
          goal: "변호사 면허증 1시간 공부하기",
          repeatType: '',
          repeatValue: ''),
      Task(
          id: 3,
          uid: 1,
          mainGoalId: 1,
          subGoalId: 1,
          goal: "법전 읽기",
          repeatType: '',
          repeatValue: ''),
    ]
        .where((goal) => goal.mainGoalId == mainGoalId)
        .where((goal) => goal.subGoalId == subGoalId)
        .where((goal) => goal.uid == uid)
        .toList();
  }
}
