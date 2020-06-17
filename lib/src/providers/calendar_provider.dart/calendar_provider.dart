import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarProvider extends ChangeNotifier {
  static DateTime date1, heureD;
  static TimeOfDay hour = new TimeOfDay.now();
  static var now = DateTime.now();
  static var fmt = DateFormat("HH:mm").format(now);
  static DateTime fmt2;
  static String debut = "début";

  DateTime getHeureD() => heureD;

  String getFmt() => fmt;
  String get fin {
    return debut;
  }

  String getDate() {
    return debut;
  }

  void setDate(DateTime value) {
    date1 = value;
    debut = '${date1.year}-${date1.month}-${date1.day}';
    notifyListeners();
  }

  void setHour(DateTime hour) {
    heureD = hour;
    notifyListeners();
  }

  void setFmt(String value) {
    fmt = value;
    notifyListeners();
  }
}
