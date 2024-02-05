import 'package:flutter/material.dart';
import 'package:pause/models/task/task.dart';
import 'package:pause/models/task_prgress/task_progress.dart';

class PopUpTaskProgressBar extends StatefulWidget {
  final List<Task> taskList;
  final List<TaskProgress> taskProgressList;

  const PopUpTaskProgressBar(
      {Key? key, required this.taskList, required this.taskProgressList})
      : super(key: key);

  @override
  State<PopUpTaskProgressBar> createState() => _PopUpTaskProgressBarState();
}

class _PopUpTaskProgressBarState extends State<PopUpTaskProgressBar> {
  @override
  Widget build(BuildContext context) {
    double progressPercentage =
        (widget.taskProgressList.length / widget.taskList.length)
            .clamp(0.0, 1.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 268,
          height: 11,
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
                width: 268 * progressPercentage,
                height: 7,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA078),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Center(
                child: Text(
                  '${(progressPercentage * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Color(0xFFFFA078),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0.20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
