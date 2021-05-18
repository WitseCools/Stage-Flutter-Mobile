import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutomaticDate with ChangeNotifier {
  String date;
  String enterDate;
  String leaveDate;
  String place;
  String taskId;
  String locationId;
  int total;
  String taskCatId;

  AutomaticDate({this.date, this.enterDate, this.leaveDate, this.place});

  @override
  String toString() {
    // TODO: implement toString
    return place.toString() +
        " van : " +
        enterDate.toString() +
        " tot : " +
        leaveDate.toString();
  }
}
