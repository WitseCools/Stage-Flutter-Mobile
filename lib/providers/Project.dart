import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Project with ChangeNotifier {
  String _date;
  String _startDate;
  String _currentProjectName;
  String _projectId;
  String _employerId;
  bool changed = false;

  String get currentProjectName {
    return _currentProjectName;
  }

  String get date {
    return _date;
  }

  String get startDate {
    return _startDate;
  }

  String get projectId {
    return _projectId;
  }

  String get employerId {
    return _employerId;
  }

  void set setCurrentDate(String datee) {
    _date = datee;
  }

  void setCurrentProjectName(String s) {
    _currentProjectName = s;
  }

  void setCurrenProjectId(String s) {
    _projectId = s;
  }

  void setEmployerId(String s) {
    _employerId = s;
  }

  void setStartDate(String startDate) {
    _startDate = startDate;
  }
}
