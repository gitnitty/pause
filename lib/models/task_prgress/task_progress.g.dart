// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskProgress _$TaskProgressFromJson(Map<String, dynamic> json) => TaskProgress(
      uid: json['uid'] as int,
      taskId: json['taskId'] as int,
      timestamp: json['timestamp'] as DateTime,
    );

Map<String, dynamic> _$TaskProgressToJson(TaskProgress instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'taskId': instance.taskId,
      'timestamp': instance.timestamp,
    };
