import 'package:flutter/material.dart';
import 'package:pause/models/main_goal/main_goal.dart';
import 'package:pause/models/sub_goal/sub_goal.dart';
import 'package:pause/models/task/task.dart';
import 'package:pause/models/task_prgress/task_progress.dart';
import 'package:pause/screens/home/components/monthly_task_container.dart';
import 'package:pause/screens/home/components/popup_task_progress_bar.dart';
import 'package:pause/service/task_service.dart';

import '../../../utils/color_utils.dart';

class MonthlySubGoalContainer extends StatefulWidget {
  final MainGoal mainGoal;
  final SubGoal subGoal;

  const MonthlySubGoalContainer(
      {Key? key, required this.mainGoal, required this.subGoal})
      : super(key: key);

  @override
  State<MonthlySubGoalContainer> createState() =>
      _MonthlySubGoalContainerState();
}

class _MonthlySubGoalContainerState extends State<MonthlySubGoalContainer> {
  bool _showMore = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: getColor(widget.mainGoal.backgroundColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "D-123 ${widget.subGoal.goal}",
                style: TextStyle(
                  color: getColor(widget.mainGoal.selectColor),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _showMore = !_showMore),
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  _showMore ? Icons.expand_more : Icons.expand_less,
                  color: getColor(widget.mainGoal.selectColor),
                ),
              ),
            ],
          ),
        ),
        PopUpTaskProgressBar(
          taskList: [
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
          ],
          taskProgressList: [
            TaskProgress(
              uid: 1,
              taskId: 1,
              timestamp: DateTime.parse("2024-02-04T10:30:00"),
            ),
            TaskProgress(
                uid: 1,
                taskId: 3,
                timestamp: DateTime.parse("2024-02-04T10:10:00")),
          ],
        ),
        if (_showMore)
          FutureBuilder(
              future: TaskService.getTaskList(
                  1, widget.mainGoal.id, widget.subGoal.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Task>? taskList = snapshot.data;
                  if (taskList == null || taskList.isEmpty) return Container();
                  return ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: taskList
                        .map((task) => MonthlyTaskContainer(
                            mainGoal: widget.mainGoal, task: task))
                        .toList(),
                  );
                }
                return Container();
              }),
      ],
    );
  }
}
