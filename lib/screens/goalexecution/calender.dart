import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/calener_controller.dart';

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
