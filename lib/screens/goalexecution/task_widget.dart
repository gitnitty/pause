import 'package:flutter/material.dart';

import 'task.dart';

class TaskInfo {
  String uid;
  String taskId;
  bool isCompleted;
  bool isEditing;

  TaskInfo({
    required this.uid,
    required this.taskId,
    this.isCompleted = false,
    this.isEditing = false,
  });
}

class TaskEditingInfo {
  bool isEditing;

  TaskEditingInfo({required this.isEditing});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<TaskInfo> taskInfos = [];
  List<Task> tasks = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Daily Goals'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskInfos.length,
              itemBuilder: (context, index) {
                return TaskWidget(
                  task: tasks[index],
                  taskInfo: taskInfos[index],
                  taskEditingInfo: TaskEditingInfo(isEditing: false),
                  onEditPressed: () {
                    _onEditPressed(index);
                  },
                  onDeletePressed: () {
                    _onDeletePressed(index);
                  },
                  onIconPressed: () {
                    _onIconPressed(index);
                  },
                  saveTaskCallback: () {
                    _saveTask(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmptyTask();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addEmptyTask() {
    setState(() {
      Task newTask = Task(name: '');
      newTask.id = UniqueKey().toString();
      newTask.repeatType = '반복 설정 안함';

      TaskInfo newTaskInfo = TaskInfo(
        uid: 'user1', // Set your uid accordingly
        taskId: newTask.id ?? '',
        isEditing: true,
      );

      tasks.add(newTask);
      taskInfos.add(newTaskInfo);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      taskInfos.removeAt(index);
      tasks.removeAt(index);
    });
  }

  void _saveTask(int index) {
    setState(() {
      taskInfos[index].isEditing = false;
      tasks[index].repeatType = '반복 설정 완료'; // Your logic to save the task
    });
  }

  void _onEditPressed(int index) {
    Navigator.pop(context); // Close the bottom sheet

    setState(() {
      taskInfos[index].isEditing = true;
      textEditingController.text = tasks[index].name ?? '';
    });
  }

  void _onDeletePressed(int index) {
    Navigator.pop(context); // Close the bottom sheet
    _deleteTask(index);
  }

  void _onIconPressed(int index) {
    _showBottomSheet(context, index);
  }

  void _showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 482,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: 58,
                    height: 3,
                    decoration: ShapeDecoration(
                      color: Color(0xFFB8B8B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 29,
                      top: 22,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: tasks[index].isEditing
                      ? TextField(
                          controller: textEditingController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.07,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )
                      : Text(
                          tasks[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.07,
                          ),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 0.2,
                  width: 330,
                  color: Color(0XFF999999),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onEditPressed(index);
                    },
                    child: Container(
                      width: 158.54,
                      height: 41.28,
                      margin: EdgeInsets.only(top: 89.59),
                      child: Stack(
                        children: [
                          Container(
                            width: 158.54,
                            height: 41.28,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEAEAEA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '수정하기',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onDeletePressed(index);
                    },
                    child: Container(
                      width: 158.54,
                      height: 41.28,
                      margin: EdgeInsets.only(top: 89.59),
                      child: Stack(
                        children: [
                          Container(
                            width: 158.54,
                            height: 41.28,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEAEAEA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '삭제하기',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 83.50,
                height: 20.64,
                margin: EdgeInsets.only(left: 50, top: 150.43),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 58.13,
                      height: 20.64,
                      child: Text(
                        '반복 설정',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 185.0),
                  child: CustomDropdownButton(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Task task;
  final TaskInfo taskInfo;
  final TaskEditingInfo taskEditingInfo;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onIconPressed;
  final VoidCallback saveTaskCallback;

  TaskWidget({
    required this.task,
    required this.taskInfo,
    required this.taskEditingInfo,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onIconPressed,
    required this.saveTaskCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 24,
            decoration: BoxDecoration(color: Colors.green),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // Existing code for handling task completion
              // ...
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: taskInfo.isCompleted ? Colors.green : Colors.white,
                border: Border.all(
                  width: 1,
                  color: Color(0xFF989898),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: taskInfo.isCompleted
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: taskInfo.isEditing
                ? Container(
                    height: 20,
                    child: TextField(
                      controller: TextEditingController(text: task.name),
                      onChanged: (value) {
                        taskInfo.taskId = value;
                      },
                      onSubmitted: (value) {
                        saveTaskCallback;
                      },
                      autofocus: true,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : Container(
                    height: 20,
                    child: Text(
                      taskInfo.taskId,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: taskInfo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: 10),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: taskInfo.isEditing
                ? GestureDetector(
                    onTap: saveTaskCallback,
                    child: Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.black,
                    ),
                  )
                : GestureDetector(
                    onTap: onIconPressed,
                    child: Icon(
                      Icons.more_horiz,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  List<String> dropdownValues = ['반복 설정 안함', '매일', '주마다', '격주마다', '매달마다'];
  String? selectedValue = '반복 설정 안함';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.66,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFBDBDBD)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFFBDBDBD)),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: selectedValue == value
                              ? Colors.black
                              : Color(0xFFBDBDBD),
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
