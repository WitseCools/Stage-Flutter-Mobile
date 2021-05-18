import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/Projects.dart';
import 'package:frontend/providers/TimeLogCat.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:frontend/providers/Timesheets.dart';
import 'package:frontend/providers/analytics.dart';
import 'package:frontend/providers/automaticDate.dart';
import 'dart:convert';
import '../providers/Tasks.dart';

import 'package:http/http.dart' as http;

class Services extends ChangeNotifier {
  String _projectId = "";
  String _token;
  String _userId;
  DateTime _date;
  String _employerId;

  String get employerId {
    return _employerId;
  }

  set projectId(String projectId) {
    _projectId = projectId;
    notifyListeners();
  }

  String get projectId {
    return _projectId;
  }

  Services(
      this._date, this._userId, this._token, this._projectId, this._employerId);
  Future<List<Tasks>> getTasks() async {
    if (_projectId != null) {
      String url = 'http://10.0.2.2:8080/api/tasks/?projectId=$_projectId';
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_token',
      });

      if (response.body != null) {
        final List<Tasks> tasks = tasksFromJson(response.body);
        return tasks;
      }
    }
  }

  Future<List<Projects>> getProjects() async {
    String url = 'http://10.0.2.2:8080/api/projects/my';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Projects> projects = projectsFromJson(response.body);

    return projects;
  }

  Future<List<AllProjectTime>> getStatic() async {
    String url =
        'http://10.0.2.2:8080/api/timesheet/all/my?employeeId=$_userId';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<AllProjectTime> projects = allProjectTimeFromJson(response.body);

    print(response.body);
    return projects;
  }

  Future<List<AllProjectTime>> getTotalHoursProject() async {
    String url =
        'http://10.0.2.2:8080/api/timesheet/calculate?projectId=$projectId';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<AllProjectTime> projects = allProjectTimeFromJson(response.body);

    print(response.body);
    return projects;
  }

  Future<List<Locations>> getLocations() async {
    String url = 'http://10.0.2.2:8080/api/locations/';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Locations> locations = locationsFromJson(response.body);

    return locations;
  }

  Future<List<Timesheets>> getAllTImesheets() async {
    String url =
        'http://10.0.2.2:8080/api/timesheet/getByProject?projectId=$_projectId';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Timesheets> timesheets = timesheetsFromJson(response.body);

    return timesheets;
  }

  Future<List<Locations>> getLocationsByEmployer() async {
    if (_employerId != null) {
      String url = 'http://10.0.2.2:8080/api/locations/project/$_employerId';
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_token',
      });
      final List<Locations> locations = locationsFromJson(response.body);
      return locations;
    }
    return null;
  }

  Future<List<TimeLogCat>> getTimeLogCat() async {
    String url = 'http://10.0.2.2:8080/api/timesheet_cat/';
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });
    final List<TimeLogCat> timeLogCat = timelogCatFromjson(response.body);

    return timeLogCat;
  }

  Future<void> updateTimesheet(TimeSheet timeSheet, String timelogId) async {
    String url = 'http://10.0.2.2:8080/api/timesheet/$timelogId';
    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {
            'startAM': '${timeSheet.startAM}',
            'stopAM': '${timeSheet.stopAM}',
            'startPM': '${timeSheet.startPM}',
            'stopPM': '${timeSheet.stopPM}',
            'employeeId': _userId,
            'taskId': timeSheet.selectedTask.taskId,
            'locationId': timeSheet.selectedLocation.locationId,
            'timeLogCatId': timeSheet.selectedTimeLogCat.timelogCatId,
            'total': timeSheet.total
          },
        ));
    print(response.body);
  }

  Future<void> addTimesheet(
      {TimeSheet timeSheet, AutomaticDate automaticDate}) async {
    const url = 'http://10.0.2.2:8080/api/timesheet/add';
    if (timeSheet != null) {
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': 'Bearer $_token',
          },
          body: json.encode(
            {
              'startAM': '${timeSheet.startAM}',
              'stopAM': '${timeSheet.stopAM}',
              'startPM': '${timeSheet.startPM}',
              'stopPM': '${timeSheet.stopPM}',
              'employeeId': _userId,
              'taskId': timeSheet.selectedTask.taskId,
              'locationId': timeSheet.selectedLocation.locationId,
              'timeLogCatId': timeSheet.selectedTimeLogCat.timelogCatId,
              'date': '$_date',
              'total': timeSheet.total
            },
          ));
    } else if (automaticDate != null) {
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': 'Bearer $_token',
          },
          body: json.encode(
            {
              'startAM':
                  '${automaticDate.date + " " + automaticDate.enterDate}',
              //'stopAM': '',
              //'startPM': '${null}',
              'stopPM': '${automaticDate.date + " " + automaticDate.leaveDate}',
              'employeeId': _userId,
              'taskId': automaticDate.taskId,
              'locationId': automaticDate.locationId,
              'timeLogCatId': automaticDate.taskCatId,
              'date': '${automaticDate.date + " " + automaticDate.enterDate}',
              'total': automaticDate.total
            },
          ));
    }
  }

  Future<void> addTimesheetVacation(TimeSheet timeSheet) async {
    const url = 'http://10.0.2.2:8080/api/timesheet/addVacation';
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {
            'startAM': '${timeSheet.startAM}',
            'stopPM': '${timeSheet.stopPM}',
            'employeeId': _userId,
            'timeLogCatId': timeSheet.selectedTimeLogCat.timelogCatId,
          },
        ));
  }

  Future<List<Timesheets>> getTimeSheetsByProjectAndDate(String date) async {
    if (_projectId != null) {
      String url =
          'http://10.0.2.2:8080/api/timesheet/project/$_projectId?date=$date';
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_token',
      });
      if (response.body != null) {
        final List<Timesheets> timesheets = timesheetsFromJson(response.body);
        return timesheets;
      }
    }
  }
}
