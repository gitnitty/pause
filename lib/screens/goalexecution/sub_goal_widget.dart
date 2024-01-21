import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pause/goal_data.dart';

import 'maingoal.dart';
import 'sub_goal.dart';
import 'task.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SubGoals'),
        ),
        body: SubGoalsList(
          uid: 'user1',
          mainGoalId: 'main_goal_id_3',
        ),
      ),
    ),
  );
}

class SubGoalsList extends StatelessWidget {
  final String uid;
  final String mainGoalId;

  SubGoalsList({required this.uid, required this.mainGoalId});

  @override
  Widget build(BuildContext context) {
    List<SubGoal> userSubGoals = dummySubGoals
        .where(
            (subGoal) => subGoal.uid == uid && subGoal.mainGoalId == mainGoalId)
        .toList();

    return ListView.builder(
      itemCount: userSubGoals.length,
      itemBuilder: (context, index) {
        SubGoal currentSubGoal = userSubGoals[index];
        return SubGoalWidget(uid: uid, subGoal: currentSubGoal);
      },
    );
  }
}

class SubGoalController extends GetxController {
  RxBool isExpanded = false.obs;

  Future<List<Task>> fetchTasks(String subGoalId) async {
    // Implement the logic to retrieve tasks associated with the sub-goal
    // For now, I'll return an empty list.
    return [];
  }
}

class SubGoalWidget extends StatefulWidget {
  final String uid;
  final SubGoal subGoal;

  SubGoalWidget({required this.uid, required this.subGoal});

  @override
  _SubGoalWidgetState createState() => _SubGoalWidgetState();
}

class _SubGoalWidgetState extends State<SubGoalWidget> {
  bool isExpanded = false;
  bool isCreatingTask = false;
  List<Task> tasks = [];
  TextEditingController taskNameController = TextEditingController();

  SubGoalController subGoalController = SubGoalController();

  Future<void> fetchAndShowTasks() async {
    if (widget.subGoal.id != null) {
      List<Task> fetchedTasks =
          await subGoalController.fetchTasks(widget.subGoal.id!);

      setState(() {
        tasks = fetchedTasks;
      });
    }
  }

  Future<void> createTask() async {
    // Create Task

    Task newTask = Task(
      id: 'new_task_id', // Replace with your logic to generate a unique ID
      name: taskNameController.text,
      mainGoalId: widget.subGoal.mainGoalId,
      subGoalId: widget.subGoal.id,
      uid: widget.uid,
      repeatType: '',
      repeatValue: '',
    );

    // Save the new task
    // Replace this with your logic to save the task, such as adding it to a list or database
    print('Task created: ${newTask.name}');

    setState(() {
      dummyTasks.add(newTask);
      print(
          'Task added to the list: ${dummyTasks.map((task) => task.name).toList()}');
    });

    // Clear the text field after creating the task
    taskNameController.clear();
  }

  void editTask(Task task) {
    // Handle the logic for editing a task
    // This could involve showing a dialog or navigating to a new screen
    print('Edit task: ${task.name}');
  }

  void deleteTask(Task task) {
    // Handle the logic for deleting a task
    // This could involve showing a confirmation dialog
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    MainGoal correspondingMainGoal = dummyMainGoals.firstWhere(
      (mainGoal) => mainGoal.id == widget.subGoal.mainGoalId,
    );
    Color? selectedColor = correspondingMainGoal.selectColor;
    Color? backgroundColor = correspondingMainGoal.backgroundColor;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              width: 330,
              height: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 28,
                        decoration: ShapeDecoration(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.71),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, top: 4, bottom: 4),
                                  child: Text(
                                    widget.subGoal.name ?? '',
                                    style: TextStyle(
                                      color: selectedColor,
                                      fontSize: 12.16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: selectedColor,
                                  size: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        // Handle onTap logic
                        if (isExpanded) {
                          fetchAndShowTasks(); // Call the method
                        }
                        setState(() {
                          isCreatingTask =
                              true; // Show the text field and check button
                        });
                        createTask();
                      },
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: ShapeDecoration(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: 12.0,
                          color: selectedColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: EdgeInsets.all(8.0),
              // Add logic to display sub-goals or tasks here
              child: Column(
                children: [
                  // Show sub-goals when expanded
                  //for (var task in tasks)
                  //TaskWidget(
                  //uid: widget.uid,
                  //task: task,
                  //),
                  // Add a button to create a new task
                  if (isCreatingTask)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 10, // Adjusted height
                            // Padding at the bottom
                            child: TextField(
                              controller: taskNameController,
                              style:
                                  TextStyle(fontSize: 10), // Adjusted font size
                              decoration: InputDecoration(
                                labelText: '',
                                hintText: '',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // Gray border at the bottom
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // Gray border at the bottom when focused
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            // Adjusted height
                            child: IconButton(
                              onPressed: () {
                                if (taskNameController.text.isNotEmpty) {
                                  createTask();
                                  setState(() {
                                    // Hide the text field and check button
                                    isCreatingTask = false;
                                  });
                                } else {
                                  // If the text field is empty, hide the text field and check button
                                  setState(() {
                                    isCreatingTask = false;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                size: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
