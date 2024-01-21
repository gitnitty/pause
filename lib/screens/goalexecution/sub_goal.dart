class SubGoal {
  String? id;
  String? mainGoalId;
  String? uid;
  String? name;

  SubGoal({
    this.id,
    this.mainGoalId,
    this.uid,
    this.name,
  });

  // Factory constructor to create SubGoal from a Map
  factory SubGoal.fromMap(Map<String, dynamic> map) {
    return SubGoal(
      id: map['id'] as String?,
      mainGoalId: map['mainGoalId'] as String?,
      uid: map['uid'] as String?,
      name: map['name'] as String?,
    );
  }

  // Convert SubGoal to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainGoalId': mainGoalId,
      'uid': uid,
      'name': name,
    };
  }
}
