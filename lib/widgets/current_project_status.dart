import 'package:flutter/material.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import '../providers/Project.dart';

class CurrentProjectStatus extends StatefulWidget {
  CurrentProjectStatus({Key key}) : super(key: key);

  @override
  _CurrentProjectStatusState createState() => _CurrentProjectStatusState();
}

class _CurrentProjectStatusState extends State<CurrentProjectStatus> {
  double totalHours;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.projectId != null
          ? service.getTotalHoursProject().then((value) {
              setState(() {
                totalHours = value.first.totaal;
              });
            })
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectData = Provider.of<Project>(context, listen: true);
    final service = Provider.of<Services>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Project",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        projectData.projectId != null
            ? Text(
                (projectData.currentProjectName),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            : Text("Please select a project",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Hours Worked",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        service.projectId != null && totalHours != null
            ? Text(
                totalHours.round().toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            : Text(""),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(child: ProgressBar()),
        ),
      ],
    );
  }
}
