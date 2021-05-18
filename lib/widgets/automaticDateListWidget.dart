import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:frontend/providers/Timesheets.dart';
import 'package:frontend/providers/automaticDate.dart';
import 'package:frontend/providers/automaticDateList.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:hexcolor/hexcolor.dart';

class AutomaticDateListWidget extends StatefulWidget {
  AutomaticDateListWidget({Key key}) : super(key: key);

  @override
  _AutomaticDateListState createState() => _AutomaticDateListState();
}

class _AutomaticDateListState extends State<AutomaticDateListWidget> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<AutomaticDateList>(context);
    final automaticDate = Provider.of<AutomaticDate>(context, listen: false);
    final selectedTask = Provider.of<TimeSheet>(context, listen: true);

    final services = Provider.of<Services>(context);

    int returnTotal(String startDate, String endDate) {
      DateTime start = DateFormat("hh:mm:ss").parse(startDate);
      DateTime end = DateFormat("hh:mm:ss").parse(endDate);
      int day = start.difference(end).inHours;

      return day;
    }

    return Container(
        child: Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Automatic hours",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  list.items.isNotEmpty
                      ? Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: list.items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  automaticDate.locationId =
                                      list.items[index].locationId;
                                  automaticDate.enterDate =
                                      list.items[index].enterDate;
                                  automaticDate.leaveDate =
                                      list.items[index].leaveDate;
                                  automaticDate.date = list.items[index].date;
                                  automaticDate.taskId =
                                      selectedTask.selectedTask.taskId;
                                  automaticDate.taskCatId = selectedTask
                                      .selectedTimeLogCat.timelogCatId;
                                  automaticDate.total = returnTotal(
                                      automaticDate.enterDate,
                                      automaticDate.leaveDate);

                                  print(automaticDate.total);

                                  services.addTimesheet(
                                      automaticDate: automaticDate);
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: ListTile(
                                    title:
                                        Text('${list.items[index].toString()}'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            "No locations detected",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                ],
              ),
            )),
      ],
    ));
  }
}
