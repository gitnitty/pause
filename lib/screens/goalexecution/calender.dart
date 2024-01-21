import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pause/screens/goalexecution/taskprogress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Calender(),
      ),
    );
  }
}

class CalendarController extends GetxController {
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  var now = DateTime.now();

  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;

  String labelText = '변호사 되기';
  Color labelColor = Color(0xFFFFA078);

  // 더미 테스트 데이터
  Map<String, Map<String, int>> tasks = {
    "2024-01-01": {"total": 5, "completed": 2},
    "2024-01-02": {"total": 3, "completed": 0},
    "2024-01-03": {"total": 7, "completed": 5},
    "2024-01-08": {"total": 5, "completed": 2},
    "2024-01-14": {"total": 5, "completed": 2},
    "2024-01-15": {"total": 3, "completed": 0},
    "2024-01-21": {"total": 7, "completed": 5},
    "2024-02-21": {"total": 7, "completed": 5},
    "2024-01-28": {"total": 5, "completed": 5},
    "2024-02-01": {"total": 5, "completed": 2},

    // 다른 날짜들에 대한 더미 데이터 추가
  };

  @override
  void onInit() {
    super.onInit();
    setFirst(now.year, now.month);
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
  }

  insertDays(int year, int month) {
    days.clear();

    int lastDay = DateTime(year, month + 1, 0).day;
    int firstWeekday = DateTime(year, month, 1).weekday;
    int totalDays = ((firstWeekday % 7) + lastDay - 1) ~/ 7 + 1;

    if (firstWeekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = firstWeekday - 1; i >= 0; i--) {
        temp.add({
          "year": month == 1 ? year - 1 : year,
          "month": month == 1 ? 12 : month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    for (var i = 1; i <= lastDay; i++) {
      var dateKey =
          "${year}-${month.toString().padLeft(2, '0')}-${i.toString().padLeft(2, '0')}";
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": false.obs,
        // 더미 데이터에서 해당 날짜에 대한 테스트 수치를 가져와서 저장
        "totalTasks": tasks[dateKey]?.containsKey("total") ?? false
            ? tasks[dateKey]!["total"]!
            : 0,
        "completedTasks": tasks[dateKey]?.containsKey("completed") ?? false
            ? tasks[dateKey]!["completed"]!
            : 0,
      });
    }

    int remainingDays = totalDays * 7 - days.length;
    if (remainingDays > 0) {
      var temp = [];
      for (var i = 1; i <= remainingDays; i++) {
        temp.add({
          "year": month == 12 ? year + 1 : year,
          "month": month == 12 ? 1 : month + 1,
          "day": i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...days, ...temp].obs;
    }
  }

  isToday(int year, int month, int day) {
    if (year == DateTime.now().year &&
        month == DateTime.now().month &&
        day == DateTime.now().day) {
      return true;
    }
    return false;
  }

  int getTotalTasks(String date) {
    return tasks[date]?.containsKey("total") ?? false
        ? tasks[date]!["total"]!
        : 0;
  }

  int getCompletedTasks(String date) {
    return tasks[date]?.containsKey("completed") ?? false
        ? tasks[date]!["completed"]!
        : 0;
  }

  void showDatePopup(BuildContext context, int year, int month, int day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 364,
            height: 507,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20), // 20은 임의로 설정한 값을 수정 가능
            ),
            child: Column(
              children: [
                // 상단 날짜 및 닫기 아이콘 부분
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 24),
                      Text(
                        '$year. ${month.toString().padLeft(2, '0')}. ${day.toString().padLeft(2, '0')}. ${getDayOfWeek(year, month, day)}',
                        style: TextStyle(
                          color: Color(0xFF989898),
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.07,
                          letterSpacing: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // 팝업 닫기
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 원하는 색상으로 변경 가능

                        Container(
                          width: 118.67,
                          height: 20,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '# $labelText',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: labelColor,
                                    fontSize: 16.84,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 100), // 중간 공백
                        Text('hi'), // 중간에 들어갈 텍스트
                        SizedBox(height: 400), // 중간 공백
                        Text('hi'), // 하단에 들어갈 텍스트
                        // 아래에 추가적인 위젯을 계속해서 넣어주세요.
                        // 예를 들어, 연도, 월, 일, 요일 x 아이콘 등의 부분을 계속 추가하세요.
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String getDayOfWeek(int year, int month, int day) {
  DateTime date = DateTime(year, month, day);
  List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  return weekdays[(date.weekday + 7) % 7];
}

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (controller.month.value == 1) {
                    controller.month(12);
                    controller.year -= 1;
                  } else {
                    controller.month -= 1;
                  }
                  controller.insertDays(
                      controller.year.value, controller.month.value);
                });
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                '${controller.year.value}년 ${controller.month.value}월',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (controller.month.value == 12) {
                    controller.month(1);
                    controller.year += 1;
                  } else {
                    controller.month += 1;
                  }
                  controller.insertDays(
                      controller.year.value, controller.month.value);
                });
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Container(
          width: 365,
          height: 30,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var i = 0; i < controller.week.length; i++)
                Container(
                  width: 30,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    controller.week[i],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                      letterSpacing: 31.40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: 350,
          child: Divider(
            thickness: 2,
            height: 1,
            color: const Color(0xFFE9E9E9),
          ),
        ),
        SizedBox(
          width: 350,
          child: Wrap(
            children: [
              for (var i = 0; i < controller.days.length; i++)
                GestureDetector(
                  onTap: () {
                    if (controller.days[i]["inMonth"]) {
                      // 팝업을 띄우는 함수 호출
                      controller.showDatePopup(
                        context,
                        controller.days[i]["year"],
                        controller.days[i]["month"],
                        controller.days[i]["day"],
                      );
                    }
                    ;
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 11.5, vertical: 8.5),
                        width: 27,
                        height: 27,
                        decoration: ShapeDecoration(
                          color: controller.isToday(
                                  controller.days[i]["year"],
                                  controller.days[i]["month"],
                                  controller.days[i]["day"])
                              ? Color(0xFFA9A3FF)
                              : null,
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: 30,
                        height: 70,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                controller.days[i]["day"].toString(),
                                style: TextStyle(
                                  color: controller.isToday(
                                          controller.days[i]["year"],
                                          controller.days[i]["month"],
                                          controller.days[i]["day"])
                                      ? Colors.white
                                      : controller.days[i]["inMonth"]
                                          ? Colors.black
                                          : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // 변경된 부분: 테스크바를 표시하거나 빈 상태로 초기화
                            if (controller.days[i]["totalTasks"] != null &&
                                controller.days[i]["totalTasks"] > 0)
                              TaskProgressBar(
                                totalTasks:
                                    controller.days[i]["totalTasks"] ?? 0,
                                completedTasks:
                                    controller.days[i]["completedTasks"] ?? 0,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
