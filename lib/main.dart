import 'package:flutter/material.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/Projects.dart';
import 'package:frontend/providers/Tasks.dart';
import 'package:frontend/providers/Timesheets.dart';
import 'package:frontend/providers/automaticDateList.dart';
import 'package:frontend/screens/add_timesheet.dart';

import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/navigation.dart';
import 'package:frontend/screens/vacation_screen.dart';

import 'package:provider/provider.dart';
import './providers/User.dart';
import './providers/Project.dart';
import './providers/TimeSheet.dart';
import 'Services/Services.dart';

// Geofencing
import 'package:frontend/providers/automaticDate.dart';
import 'dart:async';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

//Screens

import 'screens/log_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Project()),
        ChangeNotifierProvider(create: (context) => Projects()),
        ChangeNotifierProvider(create: (context) => Employer()),
        ChangeNotifierProvider(create: (context) => Locations()),
        ChangeNotifierProvider(create: (contect) => Tasks()),
        ChangeNotifierProvider(create: (context) => TimeSheet()),
        ChangeNotifierProvider(create: (context) => AutomaticDate()),
        ChangeNotifierProvider(create: (context) => AutomaticDateList()),
        ChangeNotifierProxyProvider4<TimeSheet, User, Project, Project,
            Services>(
          update: (context, timesheet, user, project, projects, prev) =>
              Services(timesheet.date, user.userId, user.token,
                  project.projectId, project.employerId),
        ),
      ],
      child: Consumer<User>(
        builder: (context, authData, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authData.isAuth ? Home_nav() : LogInScreen(),
          routes: {
            AddTimeSheet_Screen.routeName: (ctx) => AddTimeSheet_Screen(),
            VacationScreen.routeName: (ctx) => VacationScreen(),
          },
        ),
      ),
    );
  }
}
