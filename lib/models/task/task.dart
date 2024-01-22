import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final int uid;
  final int mainGoalId;
  final int subGoalId;
  final String goal;
  final String repeatType;
  final String repeatValue;

  Task({
    required this.id,
    required this.uid,
    required this.mainGoalId,
    required this.subGoalId,
    required this.goal,
    required this.repeatType,
    required this.repeatValue,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
