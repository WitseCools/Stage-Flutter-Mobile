import 'package:flutter/material.dart';
import 'package:frontend/providers/automaticDate.dart';
import 'package:frontend/providers/automaticDateList.dart';
import 'package:frontend/widgets/automaticDateListWidget.dart';
import 'package:frontend/widgets/dropdown_location.dart';
import 'package:frontend/widgets/dropdown_project.dart';
import 'package:frontend/widgets/dropdown_task.dart';
import 'package:frontend/widgets/selected_date.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/DatePicker.dart';

class AddTimeSheet_Screen extends StatefulWidget {
  AutomaticDate date;

  AddTimeSheet_Screen({this.date, Key key}) : super(key: key);

  static const routeName = '/addTimeSheet_Screen';

  @override
  _AddTimeSheet_ScreenState createState() => _AddTimeSheet_ScreenState();
}

class _AddTimeSheet_ScreenState extends State<AddTimeSheet_Screen> {
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
                            "Add hours",
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
                              edit: false,
                            ),
                            AutomaticDateListWidget()
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
