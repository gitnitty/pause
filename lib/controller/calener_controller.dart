import 'package:get/get.dart';

class CalendarController extends GetxController {
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  var now = DateTime.now();

  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;

  // 더미 테스트 데이터
  Map<String, Map<String, int>> tasks = {
    "2024-01-01": {"total": 5, "completed": 2},
    "2024-01-02": {"total": 3, "completed": 0},
    "2024-01-03": {"total": 7, "completed": 5},
    "2024-01-08": {"total": 5, "completed": 2},
    "2024-01-14": {"total": 5, "completed": 2},
    "2024-01-15": {"total": 3, "completed": 0},
    "2024-01-21": {"total": 7, "completed": 5},
    "2024-02-21": {"total": 7, "completed": 5},
    "2024-01-28": {"total": 5, "completed": 5},
    "2024-02-01": {"total": 5, "completed": 2},
    // 다른 날짜들에 대한 더미 데이터 추가
  };

  @override
  void onInit() {
    super.onInit();
    setFirst(now.year, now.month);
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
  }

  insertDays(int year, int month) {
    days.clear();

    int lastDay = DateTime(year, month + 1, 0).day;
    int firstWeekday = DateTime(year, month, 1).weekday;
    int totalDays = ((firstWeekday % 7) + lastDay - 1) ~/ 7 + 1;

    if (firstWeekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = firstWeekday - 1; i >= 0; i--) {
        temp.add({
          "year": month == 1 ? year - 1 : year,
          "month": month == 1 ? 12 : month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    for (var i = 1; i <= lastDay; i++) {
      var dateKey =
          "${year}-${month.toString().padLeft(2, '0')}-${i.toString().padLeft(2, '0')}";
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": false.obs,
        // 더미 데이터에서 해당 날짜에 대한 테스트 수치를 가져와서 저장
        "totalTasks": tasks[dateKey]?.containsKey("total") ?? false
            ? tasks[dateKey]!["total"]!
            : 0,
        "completedTasks": tasks[dateKey]?.containsKey("completed") ?? false
            ? tasks[dateKey]!["completed"]!
            : 0,
      });
    }

    int remainingDays = totalDays * 7 - days.length;
    if (remainingDays > 0) {
      var temp = [];
      for (var i = 1; i <= remainingDays; i++) {
        temp.add({
          "year": month == 12 ? year + 1 : year,
          "month": month == 12 ? 1 : month + 1,
          "day": i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...days, ...temp].obs;
    }
  }

  isToday(int year, int month, int day) {
    if (year == DateTime.now().year &&
        month == DateTime.now().month &&
        day == DateTime.now().day) {
      return true;
    }
    return false;
  }

  int getTotalTasks(String date) {
    return tasks[date]?.containsKey("total") ?? false
        ? tasks[date]!["total"]!
        : 0;
  }

  int getCompletedTasks(String date) {
    return tasks[date]?.containsKey("completed") ?? false
        ? tasks[date]!["completed"]!
        : 0;
  }

  String getDayOfWeek(int year, int month, int day) {
    DateTime date = DateTime(year, month, day);
    List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
    return weekdays[(date.weekday + 7) % 7];
  }
}
