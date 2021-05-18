import 'dart:convert';

import 'package:date_format/date_format.dart';

List<Timesheets> timesheetsFromJson(String str) =>
    List<Timesheets>.from(json.decode(str).map((x) => Timesheets.fromJson(x)));

String timesheetsToJson(List<Timesheets> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Timesheets {
  Timesheets(
      {this.timelogId,
      this.startAm,
      this.stopAm,
      this.startPm,
      this.stopPm,
      this.employeeId,
      this.taskId,
      this.locationId,
      this.timeLogCatId,
      this.total,
      this.date});

  String timelogId;
  DateTime startAm;
  DateTime stopAm;
  DateTime startPm;
  DateTime stopPm;
  String employeeId;
  String taskId;
  String locationId;
  String timeLogCatId;
  DateTime date;
  int total;

  factory Timesheets.fromJson(Map<String, dynamic> json) => Timesheets(
      timelogId: json["timelogId"],
      startAm: DateTime.parse(json["startAM"]),
      //stopAm: DateTime.parse(json["stopAM"]),
      //startPm: DateTime.parse(json["startPM"]),
      stopPm: DateTime.parse(json["stopPM"]),
      employeeId: json["employeeId"],
      taskId: json["taskId"],
      locationId: json["locationId"],
      timeLogCatId: json["timeLogCatId"],
      date: DateTime.parse(json["date"]),
      total: json["total"]);

  Map<String, dynamic> toJson() => {
        "timelogId": timelogId,
        "startAM": startAm.toIso8601String(),
        "stopAM": stopAm.toIso8601String(),
        "startPM": startPm.toIso8601String(),
        "stopPM": stopPm.toIso8601String(),
        "employeeId": employeeId,
        "taskId": taskId,
        "locationId": locationId,
        "timeLogCatId": timeLogCatId,
        "date": date,
        "total": total
      };

  @override
  String toString() {
    return timelogId.toString();
  }
}
