// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubGoal _$SubGoalFromJson(Map<String, dynamic> json) => SubGoal(
      id: json['id'] as int,
      uid: json['uid'] as int,
      mainGoalId: json['mainGoalId'] as int,
      goal: json['goal'] as String,
    );

Map<String, dynamic> _$SubGoalToJson(SubGoal instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'mainGoalId': instance.mainGoalId,
      'goal': instance.goal,
    };
