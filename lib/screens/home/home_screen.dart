import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/goalexecution/maingoal.dart';
import 'package:pause/screens/home/components/life_destination_container.dart';
import 'package:pause/screens/home/components/main_goal_tab_bar.dart';
import 'package:pause/screens/home/main_goal_weekly_page.dart';

import '../goalexecution/sub_goal.dart';
import '../goalexecution/task.dart';
import 'main_goal_monthly_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  final List<MainGoal> _mainGoalList = [
    /**
     * String? id;
        String? uid;
        Color? selectColor;
        Color? backgroundColor;
        bool? finish;
        DateTime? deadline;
        String? memo;
     */
    MainGoal(
        id: "1",
        uid: "1",
        selectColor: kPrimaryColor,
        backgroundColor: const Color(0xFFFFECE4),
        finish: false,
        deadline: DateTime(2025, 1, 1),
        memo: "변호사 되기"),
    MainGoal(
        id: "2",
        uid: "1",
        selectColor: kTertiaryColor,
        backgroundColor: const Color(0xFFEEEDFF),
        finish: false,
        deadline: DateTime(2025, 1, 1),
        memo: "학점 4.3 달성"),
    MainGoal(
        id: "3",
        uid: "1",
        selectColor: const Color(0xFFCCBD8A),
        backgroundColor: const Color(0xFFFFFBEE),
        finish: false,
        deadline: DateTime(2025, 1, 1),
        memo: "인성 바르게 하기"),
  ];

  final List<SubGoal> _subGoalList = [
    /**
     * String? id;
        String? mainGoalId;
        String? uid;
        String? name;
     */
    SubGoal(
      id: "1",
      mainGoalId: "1",
      name: "로스쿨 진학",
      uid: "1",
    ),
    SubGoal(
      id: "2",
      mainGoalId: "1",
      name: "변호사 면허증",
      uid: "1",
    ),
    SubGoal(
      id: "3",
      mainGoalId: "2",
      name: "중간고사 4.3 달성",
      uid: "1",
    ),
    SubGoal(
      id: "5",
      mainGoalId: "3",
      name: "봉사 시간 150시간 달성하기",
      uid: "1",
    ),
  ];

  final List<Task> _taskList = [
    /**
     * String? id;
        String? mainGoalId;
        String? subGoalId;
        String? uid;
        String? name;
        String? repeatType;
        String? repeatValue;
     */
    Task(id:"1",uid: "1", mainGoalId: "1", subGoalId: "1",name: "법률 기사 3개 읽기"),
    Task(id:"2",uid: "1", mainGoalId: "1", subGoalId: "1",name: "변호사 면허증 1시간 공부하기"),
    Task(id:"3",uid: "1", mainGoalId: "1", subGoalId: "1",name: "법전 읽기"),
  ];

  Widget _getPage() {
    if (_pageIndex == 0) {
      return MainGoalWeeklyPage(
        mainGoalList: _mainGoalList,
        subGoalList: _subGoalList,
        taskList: _taskList,
      );
    }
    return MainGoalMonthlyPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          const LifeDestinationContainer(),
          const SizedBox(height: 38),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text(
              '목표 도달을 위한 실천',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          MainGoalTabBar(
            currentIndex: _pageIndex,
            onTap: (int index) => setState(() => _pageIndex = index),
          ),
          const SizedBox(height: 24),
          _getPage(),
        ],
      ),
    );
  }
}
