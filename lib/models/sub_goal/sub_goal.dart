import 'package:json_annotation/json_annotation.dart';
part 'sub_goal.g.dart';

@JsonSerializable()
class SubGoal {
  final int id;
  final int uid;
  final int mainGoalId;
  final String goal;

  SubGoal({
    required this.id,
    required this.uid,
    required this.mainGoalId,
    required this.goal,
  });

  factory SubGoal.fromJson(Map<String, dynamic> json) => _$SubGoalFromJson(json);
  Map<String, dynamic> toJson() => _$SubGoalToJson(this);
}
