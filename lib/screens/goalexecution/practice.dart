import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100),
            Center(
              child: SubGoal(
                uid: 'user_id',
                maingoalid: 'main_goal_id',
                name: '학점 올리기',
                id: 'id',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class SubGoal extends StatefulWidget {
  final String id;
  final String maingoalid;
  final String uid;
  final String name;

  SubGoal({
    required this.name,
    required this.uid,
    required this.id,
    required this.maingoalid,
  });

  @override
  _SubGoalState createState() => _SubGoalState();
}

class _SubGoalState extends State<SubGoal> {
  bool isExpanded = false;
  Color containerColor = Color(0xFFEDECFF);
  Color textColor = Color(0xFFA9A2FF);

  @override
  Widget build(BuildContext context) {
    double? containerWidth = calculateContainerWidth();

    return Column(
      children: [
        SizedBox(
          width: 330,
          height: 28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: containerWidth,
                    height: 28,
                    decoration: ShapeDecoration(
                      color: containerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.71),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12.16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: textColor,
                            size: 12.0,
                          ),
                        )
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
                    openTaskDetails();
                  },
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: ShapeDecoration(
                      color: containerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      size: 12.0,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Task(
            uid: widget.uid,
            maingoalid: widget.maingoalid,
            subgoalid: widget.id,
          ),
      ],
    );
  }

  double? calculateContainerWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.name,
        style: TextStyle(
          fontSize: 12.16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + 40;
  }

  void openTaskDetails() {
    Get.to(Task(
      uid: widget.uid,
      maingoalid: widget.maingoalid,
      subgoalid: widget.id,
    ));
  }
}

class Task extends StatefulWidget {
  final String uid;
  final String maingoalid;
  final String subgoalid;

  Task({
    required this.uid,
    required this.maingoalid,
    required this.subgoalid,
  });

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isChecked = false;
  late String _taskText;

  void initState() {
    super.initState();
    _loadTaskText(); // 추가: 초기화 시 taskText 로드
  }

  void _loadTaskText() async {
    // 시뮬레이션용으로 2초 후에 가상의 데이터를 가져옴
    await Future.delayed(Duration(seconds: 2));

    // 가상의 데이터, 실제로는 여기서 데이터를 조회하여 가져와야 함
    String taskText = "가상의 Task Text";
    // 실제로는 데이터를 조회하여 가져옴

    // setState를 사용하여 상태 갱신
    if (mounted) {
      setState(() {
        _taskText = taskText;
      });
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
                margin:
                    EdgeInsets.only(top: 50.0), // Adjust top margin as needed
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    _taskText,
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
                  color: Color(0XFF999999), // 선의 색상
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("눌러짐");
                      // Add your onPressed logic here
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
                                // Add spacing between icon and text
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
                                  Icons.edit, // Replace with your pencil icon
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
                      print("눌러짐");
                      // Add your onPressed logic here
                    },
                    child: Container(
                      width: 158.54,
                      height: 41.28,
                      margin: EdgeInsets.only(
                          top: 89.59), // Adjust left margin as needed
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
                                // Add spacing between icon and text
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
                                  Icons.delete, // Replace with your pencil icon
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
                  margin: EdgeInsets.only(
                      top: 185.0), // Adjust the top margin as needed
                  child: CustomDropdownButton(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onIconPressed() {
    _showBottomSheet(context);
  }

  void _editTask() {
    // 수정하기 로직 추가
  }

  void _deleteTask() {
    // 삭제하기 로직 추가
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
          height: 50,
          child: Row(
            children: [
              Container(
                width: 3.74,
                height: 24.33,
                decoration: ShapeDecoration(
                  color: Colors.blue, // Change color as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.30),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Container(
                  width: 13.0,
                  height: 13.0,
                  decoration: BoxDecoration(
                    color: isChecked ? Colors.blue : Colors.white,
                    border: Border.all(width: 0.54, color: Color(0xFF989898)),
                    borderRadius: BorderRadius.circular(3.59),
                  ),
                  child: isChecked
                      ? Icon(
                          Icons.check,
                          size: 13.0,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth: MediaQuery.of(context).size.width - 60,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _taskText, // Change text as needed
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _onIconPressed,
                child: Container(
                  // margin: EdgeInsets.only(left: 12.0),
                  child: SvgPicture.asset(
                    'assets/icon/todo_setting.svg', // Change asset path as needed
                    width: 5,
                    height: 5,
                    color: Colors.blue, // Change color as needed
                  ),
                ),
              ),
            ],
          ),
        ),
        // ... (나머지 부분은 이전 코드와 동일하게 유지)
      ],
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
