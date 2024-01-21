class Task {
  String? id;
  String? mainGoalId;
  String? subGoalId;
  String? uid;
  String? name;
  String? repeatType;
  String? repeatValue;

  Task({
    this.id,
    this.mainGoalId,
    this.subGoalId,
    this.uid,
    this.name,
    this.repeatType,
    this.repeatValue,
  });

  // Factory constructor to create Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String?,
      mainGoalId: map['mainGoalId'] as String?,
      subGoalId: map['subGoalId'] as String?,
      uid: map['uid'] as String?,
      name: map['name'] as String?,
      repeatType: map['repeatType'] as String?,
      repeatValue: map['repeatValue'] as String?,
    );
  }

  // Convert Task to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainGoalId': mainGoalId,
      'subGoalId': subGoalId,
      'uid': uid,
      'name': name,
      'repeatType': repeatType,
      'repeatValue': repeatValue,
    };
  }
}
