import 'package:flutter/material.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:frontend/providers/TimeLogCat.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:frontend/Services/Services.dart';
import 'package:provider/provider.dart';

class PeriodSelector extends StatefulWidget {
  PeriodSelector({Key key}) : super(key: key);

  TimeLogCat vacationLog;

  @override
  _PeriodSelectorState createState() => _PeriodSelectorState();
}

GlobalKey<FormState> myFormKey = new GlobalKey();

class _PeriodSelectorState extends State<PeriodSelector> {
  DateTimeRange myDateRange;
  String beginDate;
  String endDate;

  void _submitForm() {
    final FormState form = myFormKey.currentState;
    form.save();
    setDate();
    addVacationDay();
  }

  void addVacationDay() {
    TimeSheet timeSheet = Provider.of<TimeSheet>(context, listen: false);
    Services service = Provider.of<Services>(context, listen: false);

    timeSheet.startAM = DateTime.parse(beginDate);
    timeSheet.stopPM = DateTime.parse(endDate);

    service.addTimesheetVacation(timeSheet);
  }

  void setDate() {
    List<String> iets = myDateRange.toString().split(" - ").toList();
    beginDate = iets.first;
    endDate = iets.last;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getTimeLogCat().then((logCat) {
        setState(() {
          TimeSheet timeSheet = Provider.of<TimeSheet>(context, listen: false);
          timeSheet.selectedTimeLogCat = logCat.last;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Form(
          key: myFormKey,
          child: Column(
            children: [
              SafeArea(
                child: DateRangeField(
                    context: context,
                    enabled: true,
                    initialValue: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day + 5)),
                    decoration: InputDecoration(
                      labelText: 'Date Period',
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Please select a start and end date',
                      border: OutlineInputBorder(),
                    ),
                    // initialValue: DateTimeRange(
                    //   start: DateTime.now(),
                    //   end: DateTime.now(),
                    // ),
                    validator: (value) {
                      if (value.start.isBefore(DateTime.now())) {
                        return 'Please enter a later start date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        myDateRange = value;
                        ;
                      });
                    }),
              ),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _submitForm,
                color: HexColor("#222C4A"),
              ),
              if (myDateRange != null) Text("Klaar"),
            ],
          ),
        ),
      ),
    );
  }
}
