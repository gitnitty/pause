import 'package:flutter/material.dart';
import 'package:pause/goal_data.dart';
import 'package:pause/screens/goalexecution/maingoal.dart';
import 'package:pause/screens/goalexecution/sub_goal.dart';
import 'package:pause/screens/goalexecution/sub_goal_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Main Goals'),
        ),
        body: MainGoalsList(uid: 'user1'),
      ),
    );
  }
}

class MainGoalsList extends StatelessWidget {
  final String uid;

  MainGoalsList({required this.uid});

  @override
  Widget build(BuildContext context) {
    List<MainGoal> userMainGoals =
        dummyMainGoals.where((mainGoal) => mainGoal.uid == uid).toList();

    return ListView.builder(
      itemCount: userMainGoals.length,
      itemBuilder: (context, index) {
        MainGoal currentMainGoal = userMainGoals[index];
        print("Building MainGoalsList for ID: ${currentMainGoal.id}");
        return MainGoalWidget(uid: uid, mainGoal: currentMainGoal);
      },
    );
  }
}

class MainGoalWidget extends StatefulWidget {
  final String uid;
  final MainGoal mainGoal;

  MainGoalWidget({required this.uid, required this.mainGoal});

  @override
  _MainGoalWidgetState createState() => _MainGoalWidgetState();
}

class _MainGoalWidgetState extends State<MainGoalWidget> {
  bool isExpanded = false;
  List<SubGoal> subGoals = [];

  // Fetch SubGoals associated with the MainGoal
  Future<void> fetchAndShowSubGoals(String mainGoalId) async {
    setState(() {
      subGoals = dummySubGoals
          .where((subGoal) =>
              subGoal.mainGoalId == mainGoalId && subGoal.uid == widget.uid)
          .toList();
    });
  }

  // Toggle the expansion state and fetch SubGoals when expanded
  Future<void> onArrowIconTap() async {
    if (!isExpanded) {
      await fetchAndShowSubGoals(widget.mainGoal.id.toString());
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Building MainGoalWidget for ID: ${widget.mainGoal.id}, Expanded: $isExpanded");

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 350,
              child: Row(
                children: [
                  Text(
                    '# ${widget.mainGoal.id}',
                    style: TextStyle(
                      color: widget.mainGoal.selectColor,
                      fontSize: 16.84,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: onArrowIconTap,
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: widget.mainGoal.selectColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Show sub-goals when expanded
                  for (var subGoal in subGoals)
                    SubGoalWidget(
                      subGoal: subGoal,
                      uid: widget.uid,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
