import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "../providers/TimeSheet.dart";

class SelectedDate extends StatefulWidget {
  SelectedDate({Key key}) : super(key: key);

  @override
  _SelectedDateState createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  @override
  Widget build(BuildContext context) {
    TimeSheet timesheetData = Provider.of<TimeSheet>(context, listen: false);
    String formattedData = DateFormat('dd-MM-yyyy').format(timesheetData.date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Date",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(
          formattedData,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}
