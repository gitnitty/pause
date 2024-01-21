import 'package:flutter/material.dart';
import 'package:pause/goal_data.dart';
import 'package:pause/screens/goalexecution/main_goal_widget.dart';
import 'package:pause/screens/goalexecution/weekly_calender.dart';

import 'maingoal.dart';

class WeeklyScreen extends StatefulWidget {
  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [WeekCalendar(), UserGoalsWidget(uid: 'user1')],
    );
  }
}

// Import your MainGoalWidget

class UserGoalsWidget extends StatefulWidget {
  final String uid;

  UserGoalsWidget({required this.uid});

  @override
  _UserGoalsWidgetState createState() => _UserGoalsWidgetState();
}

class _UserGoalsWidgetState extends State<UserGoalsWidget> {
  // Assume you have a method to fetch MainGoals for a given UID
  // Replace this with your actual data fetching logic
  Future<List<MainGoal>> fetchUserMainGoals(String uid) async {
    // Fetch MainGoals for the given UID (replace with your logic)
    // For now, using dummy data
    return dummyMainGoals.where((mainGoal) => mainGoal.uid == uid).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MainGoal>>(
      future: fetchUserMainGoals(widget.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No goals found.'));
        } else {
          // Display MainGoals using MainGoalWidget
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              MainGoal currentMainGoal = snapshot.data![index];
              return MainGoalWidget(
                mainGoal: currentMainGoal,
                uid: '',
              );
            },
          );
        }
      },
    );
  }
}
