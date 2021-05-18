// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Projects> projectsFromJson(String str) =>
    List<Projects>.from(json.decode(str).map((x) => Projects.fromJson(x)));

String projectsToJson(List<Projects> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Projects extends ChangeNotifier {
  Projects(
      {this.projectId,
      this.period,
      this.startDate,
      this.name,
      this.salary,
      this.employerId,
      this.employeeId});

  String projectId;
  DateTime period;
  DateTime startDate;
  String name;
  double salary;
  String employerId;
  String employeeId;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
      projectId: json["projectId"],
      period: DateTime.parse(json["period"]),
      startDate: DateTime.parse(json["startDate"]),
      name: json["name"],
      salary: json["salary"],
      employerId: json["employerId"],
      employeeId: json["employeeId"]);

  Map<String, dynamic> toJson() => {
        "projectId": projectId,
        "period": period.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "name": name,
        'salary': salary,
        "employerId": employerId,
        "employeeId": employeeId
      };
}

class Employer extends ChangeNotifier {
  Employer({
    this.employerId,
    this.name,
    this.date,
  });

  String employerId;
  String name;
  DateTime date;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        employerId: json["employerId"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "employerId": employerId,
        "name": name,
        "date": date.toIso8601String(),
      };
}
