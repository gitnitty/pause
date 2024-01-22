import 'package:json_annotation/json_annotation.dart';
part 'life_goal.g.dart';

@JsonSerializable()
class LifeGoal {
  final int uid;
  final String goal;

  LifeGoal({
    required this.uid,
    required this.goal,
  });

  factory LifeGoal.fromJson(Map<String, dynamic> json) => _$LifeGoalFromJson(json);
  Map<String, dynamic> toJson() => _$LifeGoalToJson(this);
}
