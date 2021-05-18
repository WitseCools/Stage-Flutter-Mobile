import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/Projects.dart';
import 'package:frontend/providers/Tasks.dart';
import 'package:frontend/providers/TimeLogCat.dart';

class TimeSheet extends ChangeNotifier {
  String timelogId;
  DateTime startAM;
  DateTime startPM;
  DateTime stopAM;
  DateTime stopPM;
  DateTime date;
  Tasks selectedTask;
  Projects selectedProject;
  Locations selectedLocation;
  TimeLogCat selectedTimeLogCat;
  String userId;
  int total;

  TimeSheet(
      {this.timelogId,
      this.startAM,
      this.startPM,
      this.stopAM,
      this.stopPM,
      this.selectedLocation,
      this.selectedProject,
      this.selectedTask,
      this.userId,
      this.total,
      this.selectedTimeLogCat});
}
