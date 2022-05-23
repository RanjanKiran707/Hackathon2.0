import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ActivityController extends GetxController {
  final formatter1 = DateFormat("d MMM");
  final selected = (DateTime.now().weekday - 1).obs;
  final weekDay = DateTime.now().weekday;
  final dayofMonth = DateTime.now().day;
  final PageController pageController = PageController();
  @override
  void onInit() {
    _calc();
    pageController.addListener(() {
      selected.value = pageController.page!.round();
    });
    super.onInit();
  }

  void changeSelected(int index) {
    selected.value = index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  final List<Day> dayNames = [
    Day(dayName: "Mon"),
    Day(dayName: "Tue"),
    Day(dayName: "Wed"),
    Day(dayName: "Thu"),
    Day(dayName: "Fri"),
    Day(dayName: "Sat"),
    Day(dayName: "Sun"),
  ];

  void _calc() {
    dayNames[weekDay - 1].dayNum = dayofMonth;
    int cur = weekDay - 1;
    for (var i = 1; i < 7 - cur; i++) {
      dayNames[cur + i].dayNum = dayofMonth + i;
    }

    for (var i = 1; i < cur; i--) {
      dayNames[cur - i].dayNum = dayofMonth - i;
    }

    dayNames.forEach((element) {
      debugPrint("${element.dayName} - ${element.dayNum}");
    });
  }
}

class Day {
  int? dayNum;
  String dayName;
  Day({
    this.dayNum,
    required this.dayName,
  });
}
