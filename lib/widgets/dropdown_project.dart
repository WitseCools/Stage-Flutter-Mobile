import 'package:flutter/material.dart';
import 'package:frontend/providers/User.dart';
import 'package:provider/provider.dart';
import '../providers/Project.dart';

class DropDownProject extends StatefulWidget {
  DropDownProject({Key key}) : super(key: key);

  @override
  _DropDownProjectState createState() => _DropDownProjectState();
}

class _DropDownProjectState extends State<DropDownProject> {
  @override
  Widget build(BuildContext context) {
    final projectData = Provider.of<Project>(context, listen: true);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              projectData.currentProjectName,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
