import 'package:flutter/material.dart';
import 'package:frontend/providers/Project.dart';
import 'package:frontend/providers/Projects.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:frontend/widgets/loading.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Services/Services.dart';
import '../providers/Projects.dart';
import 'package:provider/provider.dart';

class ProjectGrid extends StatefulWidget {
  ProjectGrid({Key key}) : super(key: key);

  @override
  _ProjectGridState createState() => _ProjectGridState();
}

List<Projects> _projects;

class _ProjectGridState extends State<ProjectGrid> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);

      service.getProjects().then((projects) {
        setState(() {
          _projects = projects;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: false);
    Project project = Provider.of<Project>(context, listen: true);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 350,
            height: 420,
            child: FutureBuilder(
              future: service.getProjects(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Loading();
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: _projects.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Card(
                              color: Colors.white,
                              child: InkResponse(
                                onTap: () {
                                  project.setCurrentProjectName(
                                      _projects[index].name);
                                  project.setCurrenProjectId(
                                      _projects[index].projectId);
                                  project.setEmployerId(
                                      _projects[index].employerId);
                                  /* service.projectId =
                                      _projects[index].projectId;*/
                                  project.notifyListeners();
                                },
                                child: Center(
                                    child: Text(
                                  _projects[index].name,
                                  style: TextStyle(fontSize: 15),
                                )),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: HexColor("#222C4A"), width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 170,
                              child: Card(
                                color: HexColor("#222C4A"),
                                child: Center(
                                    child: true
                                        ? Text(
                                            "Current project", //TODO huidig project bool
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : Text("Not selected")),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            )));
  }
}
