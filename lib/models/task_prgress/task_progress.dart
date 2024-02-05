import 'package:json_annotation/json_annotation.dart';

part 'task_progress.g.dart';

@JsonSerializable()
class TaskProgress {
  final int uid;
  final int taskId;
  final DateTime timestamp;

  TaskProgress({
    required this.uid,
    required this.taskId,
    required this.timestamp,
  });

  factory TaskProgress.fromJson(Map<String, dynamic> json) =>
      _$TaskProgressFromJson(json);
  Map<String, dynamic> toJson() => _$TaskProgressToJson(this);
}
