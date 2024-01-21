import 'package:flutter/material.dart';

class TaskProgressBar extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  TaskProgressBar({required this.totalTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (completedTasks / totalTasks).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '${(progressPercentage * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              color: Color(0xFFFFA078),
              fontSize: 8,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
              height: 0.20,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 35,
          height: 7,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFFFA078), // 테두리 색상, 프로그레스 바와 동일하게 설정
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            children: [
              Container(
                width: 35 * progressPercentage,
                height: 7,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA078),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Task Progress Bar'),
      ),
      body: Center(
        child: TaskProgressBar(totalTasks: 60, completedTasks: 10),
      ),
    ),
  ));
}
