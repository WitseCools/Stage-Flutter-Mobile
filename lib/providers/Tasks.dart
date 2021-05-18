import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks extends ChangeNotifier {
  Tasks({this.taskId, this.name});

  String taskId;
  String name;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        taskId: json["taskId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "name": name,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "ID: " + taskId + "naam: " + name;
  }
}
