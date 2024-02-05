import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';

class WeekCalendar extends StatefulWidget {
  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late DateTime currentWeek;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    currentWeek = DateTime.now();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${currentWeek.year}년 ${currentWeek.month}월',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    currentWeek = currentWeek.subtract(Duration(days: 7));
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (index) {
                    // Adjust the logic to start from Monday
                    DateTime currentDate = currentWeek
                        .add(Duration(days: index - currentWeek.weekday + 1));

                    return DayWidget(
                      day: currentDate.day,
                      dayOfWeek: getDayOfWeek(currentDate.weekday),
                      containerWidth: screenWidth / 15,
                      isActive: currentDate.isAtSameMomentAs(selectedDate),
                      selectedDate: selectedDate,
                      currentWeek: currentWeek,
                      onTap: () {
                        setState(() {
                          selectedDate = currentDate;
                        });
                        print('Clicked on day $currentDate');
                      },
                    );
                  }),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    currentWeek = currentWeek.add(Duration(days: 7));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        return '';
    }
  }
}

class DayWidget extends StatelessWidget {
  final int day;
  final String dayOfWeek;
  final double containerWidth;
  final bool isActive;
  final DateTime selectedDate;
  final DateTime currentWeek;
  final VoidCallback onTap;

  DayWidget({
    required this.day,
    required this.dayOfWeek,
    required this.containerWidth,
    required this.isActive,
    required this.selectedDate,
    required this.currentWeek,
    required this.onTap,
  });

  bool isToday() {
    DateTime now = DateTime.now();
    return now.year == currentWeek.year &&
        now.month == currentWeek.month &&
        now.day == day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: 50.0,
      child: Column(
        children: [
          Text(
            dayOfWeek,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: (isActive || (selectedDate == null && isToday()))
                  ? kPrimaryColor
                  : Colors.black,
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive || (selectedDate == null && isToday()))
                    ? kPrimaryColor
                    : Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: TextStyle(
                      color: isToday() ? Color(0XFFB43600) : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
