import 'package:flutter/material.dart';
import 'package:pause/screens/goalexecution/calender.dart';

class MonthlyScreen extends StatefulWidget {
  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Calender(),
      ],
    );
  }
}
