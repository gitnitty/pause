// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      uid: json['uid'] as int,
      mainGoalId: json['mainGoalId'] as int,
      subGoalId: json['subGoalId'] as int,
      goal: json['goal'] as String,
      repeatType: json['repeatType'] as String,
      repeatValue: json['repeatValue'] as String,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'mainGoalId': instance.mainGoalId,
      'subGoalId': instance.subGoalId,
      'goal': instance.goal,
      'repeatType': instance.repeatType,
      'repeatValue': instance.repeatValue,
    };
