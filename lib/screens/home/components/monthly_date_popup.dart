import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pause/controller/calener_controller.dart';
import 'package:pause/models/main_goal/main_goal.dart';
import 'package:pause/models/sub_goal/sub_goal.dart';
import 'package:pause/models/task/task.dart';
import 'package:pause/models/task_prgress/task_progress.dart';
import 'package:pause/screens/home/components/weekly_main_goal_container.dart';

import '../../../service/main_goal_service.dart';

class MonthlyDatePopUp extends StatefulWidget {
  final List<MainGoal> mainGoalList;
  final List<SubGoal> subGoalList;
  final List<Task> taskList;
  final List<TaskProgress> taskprogressList;
  final Timestamp timestamp;

  const MonthlyDatePopUp({
    Key? key,
    required this.mainGoalList,
    required this.subGoalList,
    required this.taskList,
    required this.taskprogressList,
    required this.timestamp,
  }) : super(key: key);

  @override
  State<MonthlyDatePopUp> createState() => _MonthlyDatePopUpState();
}

class _MonthlyDatePopUpState extends State<MonthlyDatePopUp> {
  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
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
                    '2024.2.5.Mon',
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
                    FutureBuilder(
                        future: MainGoalService.getMainGoalList(1),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MainGoal>? mainGoalList = snapshot.data;
                            if (mainGoalList == null || mainGoalList.isEmpty) {
                              return Container();
                            }
                            return ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: mainGoalList
                                  .map((MainGoal mainGoal) =>
                                      WeeklyMainGoalContainer(
                                          mainGoal: mainGoal))
                                  .toList(),
                            );
                          }
                          return Container();
                        }), // 하단에 들어갈 텍스트
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
  }
}
