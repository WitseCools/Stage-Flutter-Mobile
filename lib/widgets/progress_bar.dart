import 'package:flutter/material.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/providers/Projects.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/Project.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({Key key}) : super(key: key);

  DateTime startDate;
  DateTime date;
  Projects _projects;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

double calculateDate(DateTime endDate, DateTime startDate) {
  double total;
  if (endDate == null) {
    total = 0;
  } else {
    DateTime today = DateTime.now();
    total = (today.difference(startDate).inDays) /
        (endDate.difference(startDate).inDays);
  }
  return total;
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      Project project = Provider.of<Project>(context, listen: false);

      if (service.employerId != null) {
        service.getProjects().then((projects) {
          setState(() {
            widget._projects = projects.firstWhere(
                (element) => element.projectId == project.projectId);
          });
          widget.startDate = widget._projects.startDate;
          widget.date = widget._projects.period;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          LinearPercentIndicator(
            width: 314,
            animation: false,
            animationDuration: 1000,
            lineHeight: 20.0,
            percent: calculateDate(widget.date, widget.startDate),
            center: Text(
              calculateDate(widget.date, widget.startDate)
                      .toStringAsFixed(2)
                      .split('.')[1] +
                  "%",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.blue[800],
            backgroundColor: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              Icons.flag,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
