import 'package:json_annotation/json_annotation.dart';
part 'main_goal.g.dart';

@JsonSerializable()
class MainGoal {
  final int id;
  final int uid;
  final int selectColor;
  final int backgroundColor;
  final bool finish;
  final String deadline;
  final String goal;

  MainGoal({
    required this.id,
    required this.uid,
    required this.selectColor,
    required this.backgroundColor,
    required this.finish,
    required this.deadline,
    required this.goal,
  });

  factory MainGoal.fromJson(Map<String, dynamic> json) => _$MainGoalFromJson(json);
  Map<String, dynamic> toJson() => _$MainGoalToJson(this);
}
