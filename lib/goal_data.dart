import 'package:flutter/material.dart';
import 'package:pause/screens/goalexecution/maingoal.dart';

import 'screens/goalexecution/sub_goal.dart';
import 'screens/goalexecution/task.dart';

List<MainGoal> dummyMainGoals = [
  MainGoal(
    id: 'main_goal_id_5',
    uid: 'user1',
    selectColor: Color.fromARGB(255, 38, 148, 71),
    backgroundColor: Colors.blue,
    finish: true,
    deadline: DateTime(2023, 12, 31),
    memo: 'Finish this goal by the end of the year',
  ),
  MainGoal(
    id: 'main_goal_id_3',
    uid: 'user1',
    selectColor: Color.fromARGB(255, 122, 43, 43),
    backgroundColor: Color.fromARGB(255, 245, 196, 163),
    finish: true,
    deadline: DateTime(2024, 6, 30),
    memo: 'Finish this goal by the end of the year',
  ),
  MainGoal(
    id: 'main_goal_id_4',
    uid: 'user1',
    selectColor: Colors.green,
    backgroundColor: Colors.yellow,
    finish: true,
    deadline: DateTime(2024, 6, 30),
    memo: 'Completed goal',
  ),
  MainGoal(
    id: 'main_goal_id_2',
    uid: 'user2',
    selectColor: Color.fromARGB(255, 28, 53, 191),
    backgroundColor: Colors.yellow,
    finish: true,
    deadline: DateTime(2024, 6, 30),
    memo: 'Completed goal',
  ),
  // Add more dummy data as needed
];

List<SubGoal> dummySubGoals = [
  SubGoal(
    id: 'subgoal1',
    uid: 'user1',
    mainGoalId: 'main_goal_id_3',
    name: 'Complete Chapter 1',
  ),
  SubGoal(
    id: 'subgoal2',
    uid: 'user1',
    mainGoalId: 'main_goal_id_3',
    name: 'Finish Assignment 1',
  ),
  SubGoal(
    id: 'subgoal3',
    uid: 'user2',
    mainGoalId: 'main_goal_id_1',
    name: 'Read Book',
  ),
  SubGoal(
    id: 'subgoal4',
    uid: 'user2',
    mainGoalId: 'main_goal_id_3',
    name: 'Write Summary',
  ),
  // Add more dummy data as needed
];

List<Task> dummyTasks = [
  Task(
    id: 'task1',
    mainGoalId: 'main_goal_id_3',
    subGoalId: 'subgoal1',
    uid: 'user1',
    repeatType: 'daily',
    repeatValue: '1',
    name: "바라기",
  ),
  Task(
    id: 'task2',
    mainGoalId: 'main_goal_id_3',
    subGoalId: 'subgoal1',
    uid: 'user1',
    repeatType: 'weekly',
    repeatValue: '2',
    name: "보기",
  ),
  Task(
    id: 'task3',
    mainGoalId: 'main_goal_id_1',
    subGoalId: 'subgoal3',
    uid: 'user2',
    repeatType: 'monthly',
    repeatValue: '3',
    name: "바라보기",
  ),
  Task(
    id: 'task4',
    mainGoalId: 'main_goal_id_1',
    subGoalId: 'subgoal4',
    uid: 'user2',
    repeatType: 'daily',
    repeatValue: '1',
    name: "일어나기",
  ),
  // Add more dummy data as needed
];
