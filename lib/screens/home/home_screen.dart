import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/home/components/life_goal_container.dart';
import 'package:pause/screens/home/main_goal_weekly_page.dart';
import '../../models/main_goal/main_goal.dart';
import '../../models/sub_goal/sub_goal.dart';
import '../../models/task/task.dart';
import 'components/home_goal_tab_bar.dart';
import 'main_goal_monthly_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  final List<MainGoal> _mainGoalList = [
    MainGoal(
        id: 1,
        uid: 1,
        selectColor: kPrimaryColor.value,
        backgroundColor: 0xFFFFECE4,
        finish: false,
        deadline: DateTime(2025, 1, 1).toString(),
        goal: "변호사 되기"),
    MainGoal(
        id: 2,
        uid: 1,
        selectColor: kTertiaryColor.value,
        backgroundColor: 0xFFEEEDFF,
        finish: false,
        deadline: DateTime(2025, 1, 1).toString(),
        goal: "학점 4.3 달성"),
    MainGoal(
        id: 3,
        uid: 1,
        selectColor: 0xFFCCBD8A,
        backgroundColor: 0xFFFFFBEE,
        finish: false,
        deadline: DateTime(2025, 1, 1).toString(),
        goal: "인성 바르게 하기"),
  ];

  final List<SubGoal> _subGoalList = [
    SubGoal(
      id: 1,
      uid: 1,
      mainGoalId: 1,
      goal: "로스쿨 진학",
    ),
    SubGoal(
      id: 2,
      uid: 1,
      mainGoalId: 1,
      goal: "변호사 면허증",
    ),
    SubGoal(
      id: 3,
      uid: 1,
      mainGoalId: 2,
      goal: "중간고사 4.3 달성",
    ),
    SubGoal(
      id: 4,
      uid: 1,
      mainGoalId: 3,
      goal: "봉사 시간 150시간 달성하기",
    ),
  ];

  final List<Task> _taskList = [
    Task(
        id: 1,
        uid: 1,
        mainGoalId: 1,
        subGoalId: 1,
        goal: "법률 기사 3개 읽기",
        repeatType: '',
        repeatValue: ''),
    Task(
        id: 2,
        uid: 1,
        mainGoalId: 1,
        subGoalId: 1,
        goal: "변호사 면허증 1시간 공부하기",
        repeatType: '',
        repeatValue: ''),
    Task(
        id: 3,
        uid: 1,
        mainGoalId: 1,
        subGoalId: 1,
        goal: "법전 읽기",
        repeatType: '',
        repeatValue: ''),
  ];

  Widget _getPage() {
    if (_pageIndex == 0) {
      return MainGoalWeeklyPage(
        mainGoalList: _mainGoalList,
        subGoalList: _subGoalList,
        taskList: _taskList,
      );
    }
    return const MainGoalMonthlyPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          const LifeGoalContainer(),
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
          HomeGoalTabBar(
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
