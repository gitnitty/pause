import 'package:flutter/material.dart';
import 'package:pause/models/main_goal/main_goal.dart';
import 'package:pause/models/sub_goal/sub_goal.dart';
import 'package:pause/screens/home/components/monthly_sub_goal_container.dart';
import 'package:pause/service/sub_goal_service.dart';

import '../../../utils/color_utils.dart';

class MonthlyMainGoalContainer extends StatefulWidget {
  final MainGoal mainGoal;

  const MonthlyMainGoalContainer({Key? key, required this.mainGoal})
      : super(key: key);

  @override
  State<MonthlyMainGoalContainer> createState() =>
      _MonthlyMainGoalContainerState();
}

class _MonthlyMainGoalContainerState extends State<MonthlyMainGoalContainer> {
  bool _showMore = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Row(
            children: [
              Text(
                '# ${widget.mainGoal.goal}',
                style: TextStyle(
                  fontSize: 22,
                  color: getColor(widget.mainGoal.selectColor),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 14),
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
        const SizedBox(height: 20),
        if (_showMore)
          FutureBuilder(
              future: SubGoalService.getSubGoalList(1, widget.mainGoal.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SubGoal>? subGoalList = snapshot.data;
                  if (subGoalList == null || subGoalList.isEmpty) {
                    return Container();
                  }
                  return ListView(
                    padding: const EdgeInsets.only(bottom: 12),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: subGoalList
                        .map((goal) => MonthlySubGoalContainer(
                            mainGoal: widget.mainGoal, subGoal: goal))
                        .toList(),
                  );
                }
                return Container();
              }),
      ],
    );
  }
}
