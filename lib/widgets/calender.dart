import 'package:flutter/material.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/providers/Project.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:frontend/providers/Timesheets.dart';
import 'package:frontend/providers/automaticDateList.dart';
import 'package:frontend/screens/edit_timesheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  int totalLocations;

  Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

List<Timesheets> _timesheets;
Map<DateTime, List<String>> events = {};

class _CalenderState extends State<Calender> {
  CalendarController _calendarController = CalendarController();

  void getTimesheetByDate(DateTime date) {
    Services service = Provider.of<Services>(context, listen: false);
    TimeSheet timesheetData = Provider.of<TimeSheet>(context, listen: false);

    timesheetData.date = date;
    service
        .getTimeSheetsByProjectAndDate(timesheetData.date.toString())
        .then((value) {
      _timesheets = value;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getLocations().then((value) {
        widget.totalLocations = value.length;
      });
      AutomaticDateList detectedList =
          Provider.of<AutomaticDateList>(context, listen: false);

      widget.totalLocations = detectedList.items.length;

      service.projectId != null
          ? service.getAllTImesheets().then((value) {
              events.clear();
              for (var item in value) {
                events.addAll({
                  item.date: [item.timelogId],
                });
              }
              print(events.length);
            })
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locatedData = Provider.of<AutomaticDateList>(context);
    TimeSheet timesheetData = Provider.of<TimeSheet>(context, listen: false);

    timesheetData.date = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(8),
            child: TableCalendar(
                events: events,
                rowHeight: 50,
                calendarController: _calendarController,
                onDayLongPressed: (day, events, holidays) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          width: double.maxFinite,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text('Edit timesheets',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Total:" +
                                            _timesheets.length.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: _timesheets.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: _timesheets.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditTimesheetScreen(
                                                              timesheet:
                                                                  _timesheets[
                                                                      index],
                                                            )));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    '${_timesheets[index].toString()}'),
                                              ),
                                            );
                                          },
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Timelog(s) has been added on this date",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                calendarStyle: CalendarStyle(
                    //eventDayStyle: TextStyle(color: Colors.green),
                    markersColor: Colors.green,
                    todayColor: HexColor("#222C4A"),
                    selectedColor: Colors.blue[900],
                    weekdayStyle: TextStyle(color: HexColor("#222C4A"))),
                onDaySelected: (day, events, holidays) => {
                      timesheetData.date = day,
                      timesheetData.notifyListeners(),
                      getTimesheetByDate(day)
                    })),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              locatedData.getItems.isNotEmpty
                  ? Text("Locations detected: ${locatedData.getItems.length}",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontWeight: FontWeight.bold))
                  : Text("No Locations Detected",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontWeight: FontWeight.bold)),
              Text("Locations confirmed: 0 ",
                  style: TextStyle(
                      color: HexColor("#222C4A"), fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}
