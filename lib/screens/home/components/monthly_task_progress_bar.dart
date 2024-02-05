import 'package:flutter/material.dart';
import 'package:pause/models/task/task.dart';
import 'package:pause/models/task_prgress/task_progress.dart';

class MonthlyProgressBar extends StatefulWidget {
  final List<Task> taskList;
  final List<TaskProgress> taskProgressList;

  const MonthlyProgressBar(
      {Key? key, required this.taskList, required this.taskProgressList})
      : super(key: key);

  @override
  State<MonthlyProgressBar> createState() => _MonthlyProgressBarState();
}

class _MonthlyProgressBarState extends State<MonthlyProgressBar> {
  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        (widget.taskProgressList.length / widget.taskList.length)
            .clamp(0.0, 1.0);

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
