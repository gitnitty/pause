import 'package:flutter/material.dart';
import 'package:pause/screens/goalexecution/monthly_screen.dart';
import 'package:pause/screens/goalexecution/weekly_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GoalExcutionScreen());
  }
}

class GoalExcutionScreen extends StatefulWidget {
  const GoalExcutionScreen({super.key});

  @override
  State<GoalExcutionScreen> createState() => _GoalExcutionScreenState();
}

class _GoalExcutionScreenState extends State<GoalExcutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  SizedBox(
                    width: 338,
                    child: Text(
                      '나의 인생목표',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF010101),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                width: 341,
                height: 117,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0XFFF2F2FA), width: 2.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '“명예로운 삶을 통해\n행복하기”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 20,
                    fontFamily: 'MaruBuri',
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 3,
                  ),
                  SizedBox(
                    width: 338,
                    child: Text(
                      '목표 달성을 위한 실천',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF010101),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ToggleButtonWidget(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ToggleButtonWidget extends StatefulWidget {
  @override
  _ToggleButtonWidgetState createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  bool isWeeklySelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 321,
        height: 55,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFD9D9D9)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isWeeklySelected = true;
                });
              },
              child: Container(
                width: 58,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2, // 원하는 아래 줄의 두께
                      color: isWeeklySelected
                          ? Color(0xFFFFA078)
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '주간',
                  style: TextStyle(
                    color: isWeeklySelected
                        ? Color(0xFFFFA078)
                        : Color(0xFFCCCCCC),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.06,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 104),
            GestureDetector(
              onTap: () {
                setState(() {
                  isWeeklySelected = false;
                });
              },
              child: Container(
                width: 58,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2, // 원하는 아래 줄의 두께
                      color: isWeeklySelected
                          ? Colors.transparent
                          : Color(0xFFFFA078),
                    ),
                  ),
                ),
                child: Text(
                  '월간',
                  style: TextStyle(
                    color: isWeeklySelected
                        ? Color(0xFFCCCCCC)
                        : Color(0xFFFFA078),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.06,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        height: 24,
      ),
      isWeeklySelected ? WeeklyScreen() : MonthlyScreen(),
    ]);
  }
}
