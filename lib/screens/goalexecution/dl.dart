import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  String text;
  bool isCompleted;
  bool isEditing;

  Todo({required this.text, this.isCompleted = false, this.isEditing = false});
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
  List<Todo> todos = [];
  TextEditingController textController = TextEditingController();
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
          // Check if there are todos
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
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
                          setState(() {
                            todos[index].isCompleted =
                                !todos[index].isCompleted;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: todos[index].isCompleted
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Color(0xFF989898),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: todos[index].isCompleted
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
                        child: todos[index].isEditing
                            ? Container(
                                height: 20,
                                child: TextField(
                                  controller: TextEditingController(
                                      text: todos[index].text),
                                  onChanged: (value) {
                                    todos[index].text = value;
                                  },
                                  onSubmitted: (value) {
                                    setState(() {
                                      todos[index].isEditing = false;
                                    });
                                  },
                                  autofocus: true,
                                  maxLines: 1, // 최대 1줄까지만 표시하도록 설정
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                            : Container(
                                height: 20,
                                child: Text(
                                  todos[index].text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    decoration: todos[index].isCompleted
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
                        child: todos[index].isEditing
                            ? GestureDetector(
                                onTap: () {
                                  _saveTodo(index);
                                },
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  _showBottomSheet(index);
                                },
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmptyTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addEmptyTodo() {
    setState(() {
      Todo newTodo = Todo(text: '');
      newTodo.isEditing = true; // 새로 추가된 Todo를 편집 상태로 설정
      todos.add(newTodo);
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _saveTodo(int index) {
    setState(() {
      todos[index].isEditing = false;
    });
  }

  void _showBottomSheet(int index) {
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
                  child: todos[index].isEditing
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
                          todos[index].text,
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

  void _onEditPressed(int index) {
    Navigator.pop(context); // Close the bottom sheet

    setState(() {
      if (todos[index].isEditing) {
        _saveTodo(index);
      } else {
        todos[index].isEditing = true;
        textEditingController.text = todos[index].text;
      }
    });
  }

  void _onDeletePressed(int index) {
    Navigator.pop(context); // Close the bottom sheet
    _deleteTodo(index);
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
