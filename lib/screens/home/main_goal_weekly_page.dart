import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/constants/constants_value.dart';
import '../goalexecution/maingoal.dart';
import '../goalexecution/sub_goal.dart';
import '../goalexecution/task.dart';

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
          ...widget.mainGoalList
              .map((MainGoal mainGoal) => kMainGoalContainer(mainGoal))
              .toList(),
        ]);
  }

  Widget kMainGoalContainer(MainGoal mainGoal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Row(
            children: [
              Text(
                '# ${mainGoal.memo}',
                style: TextStyle(
                  fontSize: 22,
                  color: mainGoal.selectColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 14),
              Icon(
                Icons.expand_more,
                color: mainGoal.selectColor,
              ),
              //Icon(Icons.expand_less),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...widget.subGoalList
            .where((element) => element.mainGoalId == mainGoal.id)
            .map((SubGoal subGoal) => kSubGoalContainer(mainGoal, subGoal))
            .toList(),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget kSubGoalContainer(MainGoal mainGoal, SubGoal subGoal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: mainGoal.backgroundColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "D-123 ${subGoal.name}",
                style: TextStyle(
                  color: mainGoal.selectColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.expand_less, color: mainGoal.selectColor),
            ],
          ),
        ),
        ...widget.taskList
            .where((element) => element.mainGoalId == mainGoal.id)
            .where((element) => element.subGoalId == subGoal.id)
            .map((Task task) => kTaskContainer(mainGoal, task))
            .toList(),
      ],
    );
  }

  Widget kTaskContainer(MainGoal mainGoal, Task task) {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 30, bottom: 8),
      padding: const EdgeInsets.only(
        left: 10,
        right: 18,
      ),
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFF999999).withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 38,
            decoration: BoxDecoration(
              color: mainGoal.selectColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.name ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                '설정',
                style: TextStyle(
                  color: Color(0xFF425884),
                  fontSize: 10,
                ),
              ),
            ],
          )),
          Checkbox(
            value: int.parse(task.id ?? "1").isEven,
            onChanged: (value) {},
            activeColor: mainGoal.selectColor,
            side: const BorderSide(
              width: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
