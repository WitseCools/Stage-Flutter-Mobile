import 'package:flutter/material.dart';
import 'package:frontend/providers/Timesheets.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/dropdown_project.dart';
import '../widgets/dropdown_task.dart';
import '../widgets/dropdown_location.dart';
import '../widgets/DatePicker.dart';
import '../widgets/selected_date.dart';

class EditTimesheetScreen extends StatefulWidget {
  Timesheets timesheet;
  EditTimesheetScreen({this.timesheet, Key key}) : super(key: key);

  @override
  _EditTimesheetScreenState createState() => _EditTimesheetScreenState();
}

class _EditTimesheetScreenState extends State<EditTimesheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: HexColor("#222C4A"),
                  child: Card(
                    color: HexColor("#222C4A"),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text(
                            "Edit Timelog",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsetsDirectional.only(top: 10),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [DropDownProject()],
                                    ),
                                    Column(
                                      children: [DropDownTask()],
                                    ),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [SelectedDate()],
                                  ),
                                  Column(
                                    children: [DropDownLocation()],
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(100, 100))),
                      elevation: 2,
                      color: Colors.grey[300],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                widthFactor: 2,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Gepresteerde uren",
                                    style: TextStyle(
                                        color: HexColor("#222C4A"),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )),
                            DatePicker(
                                edit: true,
                                timelogId: widget.timesheet.timelogId),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
