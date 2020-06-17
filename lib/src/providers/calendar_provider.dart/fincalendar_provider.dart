import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinCalendarProvider extends ChangeNotifier {
  static String _fin = "fin";
  static DateTime date1, heureF;
  static TimeOfDay hour = new TimeOfDay.now();
  static var now = DateTime.now();
  static var fmt = DateFormat("HH:mm").format(now);

  DateTime getHeureF() => heureF;

  String getFmt() => fmt;
  String get fin {
    return _fin;
  }

  void add(DateTime a, DateTime b) {
    _fin = b.toString();
    notifyListeners();
  }

  String getDate() {
    return _fin;
  }

  void setDate(DateTime value) {
    date1 = value;
    _fin = '${date1.year}-${date1.month}-${date1.day}';
    notifyListeners();
  }

  void setFmt(String value) {
    fmt = value;
    notifyListeners();
  }
}
