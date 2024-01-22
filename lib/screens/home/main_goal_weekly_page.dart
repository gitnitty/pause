import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/constants/constants_value.dart';
import 'package:pause/screens/home/components/weekly_main_goal_container.dart';
import 'package:pause/services/main_goal_service.dart';
import 'package:pause/services/sub_goal_service.dart';
import 'package:pause/utils/color_utils.dart';
import '../../models/main_goal/main_goal.dart';
import '../../models/sub_goal/sub_goal.dart';
import '../../models/task/task.dart';

class MainGoalWeeklyPage extends StatefulWidget {
  final List<MainGoal> mainGoalList;
  final List<SubGoal> subGoalList;
  final List<Task> taskList;

  const MainGoalWeeklyPage({
    Key? key,
    required this.mainGoalList,
    required this.subGoalList,
    required this.taskList,
  }) : super(key: key);

  @override
  State<MainGoalWeeklyPage> createState() => _MainGoalWeeklyPageState();
}

class _MainGoalWeeklyPageState extends State<MainGoalWeeklyPage> {
  late DateTime _weekDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _weekDate = DateTime.now();
    _selectedDate = DateTime.now();
  }

  bool isSelectedDate(DateTime dateTime) {
    if (dateTime.year != _selectedDate.year) return false;
    if (dateTime.month != _selectedDate.month) return false;
    if (dateTime.day != _selectedDate.day) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '${_selectedDate.year}년 ${_selectedDate.month}월',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: kBlackColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _weekDate = _weekDate.subtract(const Duration(days: 7));
                    _selectedDate = _weekDate;
                  }),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 12,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [0, 1, 2, 3, 4, 5, 6].map((int addDay) {
                    DateTime date = _weekDate.add(Duration(days: addDay));

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedDate = date),
                        child: Column(
                          children: [
                            Text(
                              kWeekDay[date.weekday - 1],
                              style: TextStyle(
                                fontSize: 10,
                                height: 22 / 10,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 27,
                              height: 27,
                              decoration: BoxDecoration(
                                color: isSelectedDate(date)
                                    ? kPrimaryColor
                                    : const Color(0xFFCCCCCC),
                                borderRadius: BorderRadius.circular(27),
                              ),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 22 / 11,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),
                GestureDetector(
                  onTap: () => setState(() {
                    _weekDate = _weekDate.add(const Duration(days: 7));
                    _selectedDate = _weekDate;
                  }),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 1,
            color: const Color(0xFFD9D9D9),
          ),
          const SizedBox(height: 20),
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
                        .map(
                            (MainGoal mainGoal) => WeeklyMainGoalContainer(mainGoal: mainGoal))
                        .toList(),
                  );
                }
                return Container();
              }),
        ]);
  }

}
