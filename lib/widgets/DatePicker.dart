import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:frontend/models/http_exception.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/Tasks.dart';
import 'package:frontend/providers/TimeSheet.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../providers/User.dart';
import '../Services/Services.dart';

class DatePicker extends StatefulWidget {
  bool edit = false;
  String timelogId;
  bool disableButton = true;

  DatePicker({this.timelogId, this.edit, key}) : super(key: key);

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DatePicker> {
  TimeOfDay _timeSAM = TimeOfDay.now().replacing(minute: 30);
  TimeOfDay _timeSPM = TimeOfDay.now().replacing(minute: 30);
  TimeOfDay _timeSTAM = TimeOfDay.now().replacing(minute: 30);
  TimeOfDay _timeSTPM = TimeOfDay.now().replacing(minute: 30);

  bool iosStyle = true;

  Tasks task;
  Locations location;
  String warning = "";

  Map<String, DateTime> _timeData = {
    'startAM': null,
    'startPM': null,
    'stopAM': null,
    'stopPM': null,
  };

  void onTimeChangedSAM(TimeOfDay newTime) {
    setState(() {
      _timeSAM = newTime;
    });
  }

  void onTimeChangedSPM(TimeOfDay newTime) {
    setState(() {
      _timeSPM = newTime;
    });
  }

  void onTimeChangedSTAM(TimeOfDay newTime) {
    setState(() {
      _timeSTAM = newTime;
    });
  }

  void onTimeChangedSTPM(TimeOfDay newTime) {
    setState(() {
      _timeSTPM = newTime;
    });
  }

  int returnTotal() {
    int morning = _timeData['stopAM'].difference(_timeData['startAM']).inHours;
    int day = _timeData['stopPM'].difference(_timeData['startPM']).inHours;
    return morning + day;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      if (service.projectId != null) {
        service.getTasks().then((tasks) {
          setState(() {});
        });
      }

      service.getLocations().then((locations) {
        setState(() {
          location = locations.first;
        });
      });

      service.getTimeLogCat().then((timeLogCat) {
        setState(() {
          final timesheett = Provider.of<TimeSheet>(context, listen: false);
          timesheett.selectedTimeLogCat = timeLogCat.first;
        });
      });
    });
  }

  bool validate() {
    if (_timeData["startAM"] != null &&
        _timeData["stopAM"] != null &&
        _timeData['stopPM'] != null &&
        _timeData['startPM'] != null) {
      if (_timeData['startAM'].isAfter(_timeData['stopAM'])) {
        return false;
      } else if (_timeData['startPM'].isAfter(_timeData['stopPM'])) {
        return false;
      } else if (_timeData['startPM'].isBefore(_timeData['stopAM'])) {
        return false;
      } else
        return true;
    } else {
      return false;
    }
  }

  void submit(bool continuee) {
    if (continuee) {
      final user = Provider.of<User>(context, listen: false);
      final timesheett = Provider.of<TimeSheet>(context, listen: false);

      timesheett.startAM = _timeData['startAM'];
      timesheett.startPM = _timeData['startPM'];
      timesheett.stopAM = _timeData['stopAM'];
      timesheett.stopPM = _timeData['stopPM'];
      timesheett.userId = user.userId;
      timesheett.total = returnTotal();

      final myservice = Provider.of<Services>(context, listen: false);
      if (widget.edit) {
        myservice.updateTimesheet(timesheett, widget.timelogId);
      } else {
        myservice.addTimesheet(timeSheet: timesheett);
      }
    } else
      print("Cant add values");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  Text("From"),
                  FlatButton(
                    minWidth: 20,
                    child: Text(
                      _timeSAM.hour.toString() +
                          ":" +
                          _timeSAM.minute.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: HexColor("#222C4A"),
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _timeSAM,
                          onChange: onTimeChangedSAM,
                          minuteInterval: null,
                          disableHour: false,
                          disableMinute: false,
                          is24HrFormat: true,
                          minMinute: 0,
                          maxMinute: 59,
                          onChangeDateTime: (DateTime dateTimeSAM) {
                            _timeData['startAM'] = dateTimeSAM;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  Text("Until"),
                  FlatButton(
                    minWidth: 20,
                    child: Text(
                      _timeSPM.hour.toString() +
                          ":" +
                          _timeSPM.minute.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: HexColor("#222C4A"),
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _timeSPM,
                          onChange: onTimeChangedSPM,
                          minuteInterval: null,
                          disableHour: false,
                          disableMinute: false,
                          is24HrFormat: true,
                          minMinute: 0,
                          maxMinute: 59,
                          onChangeDateTime: (DateTime dateTimeSPM) {
                            _timeData['stopAM'] = dateTimeSPM;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text("From"),
                FlatButton(
                  minWidth: 20,
                  child: Text(
                    _timeSTAM.hour.toString() +
                        ":" +
                        _timeSTAM.minute.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor("#222C4A"),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _timeSTAM,
                        onChange: onTimeChangedSTAM,
                        minuteInterval: null,
                        disableHour: false,
                        disableMinute: false,
                        is24HrFormat: true,
                        minMinute: 0,
                        maxMinute: 59,
                        onChangeDateTime: (DateTime dateTimeSTAM) {
                          _timeData['startPM'] = dateTimeSTAM;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                Text("Until"),
                FlatButton(
                  minWidth: 20,
                  child: Text(
                    _timeSTPM.hour.toString() +
                        ":" +
                        _timeSTPM.minute.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor("#222C4A"),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _timeSTPM,
                        onChange: onTimeChangedSTPM,
                        minuteInterval: null,
                        disableHour: false,
                        disableMinute: false,
                        is24HrFormat: true,
                        minMinute: 0,
                        maxMinute: 59,
                        onChangeDateTime: (DateTime dateTimeSTPM) {
                          _timeData['stopPM'] = dateTimeSTPM;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                RaisedButton(
                    color: HexColor("#222C4A"),
                    onPressed: () {
                      setState(() {
                        bool continuee = validate();
                        submit(continuee);
                        if (continuee == true) {
                          Navigator.pop(context);
                          warning = "";
                        } else
                          warning = "Please check dates";
                      });
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
                Text(
                  warning,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ))
      ],
    );
  }
}
