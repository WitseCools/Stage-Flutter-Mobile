import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:frontend/Services/Services.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/automaticDateList.dart';

//Screens
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/projects_screen.dart';
import 'package:frontend/screens/statics_screen.dart';
import 'package:geofence_service/geofence_service.dart';

//Geo
import 'package:frontend/providers/automaticDate.dart';
import 'dart:async';
import 'dart:developer' as dev;
import 'package:geofence_service/geofence_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:hexcolor/hexcolor.dart';

class Home_nav extends StatefulWidget {
  bool isStarted = false;
  String enterDate;
  List<Locations> geoLocations = [];

  List<AutomaticDate> list = [];

  @override
  _home_navState createState() => _home_navState();
}

class _home_navState extends State<Home_nav> {
  final geofenceService = GeofenceService(interval: 2000);
  final activityController = StreamController<Activity>();
  final geofenceController = StreamController<Geofence>();
  final geofenceList = <Geofence>[];

  void startGeofencing() {
    if (widget.isStarted == false) {
      print("SERVICE STARTED");

      geofenceService.setOnGeofenceStatusChanged(onGeofenceStatusChanged);
      geofenceService.setOnActivityChanged(onActivityChanged);
      geofenceService.setOnStreamError(onError);
      geofenceService.start(geofenceList).catchError(onError);

      widget.isStarted = true;
    }
  }

  void onGeofenceStatusChanged(Geofence geofence, GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus) {
    geofenceController.sink.add(geofence);
    AutomaticDate automaticDateData = AutomaticDate();
    automaticDateData.place = geofence.id;
    automaticDateData.locationId = geofence.data;

    automaticDateData.date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    if (geofenceStatus == GeofenceStatus.ENTER) {
      print("enter");
      widget.enterDate = DateFormat("HH:mm:ss").format(DateTime.now());
    } else {
      print("exit");
      automaticDateData.leaveDate =
          DateFormat("HH:mm:ss").format(DateTime.now());
      automaticDateData.enterDate = widget.enterDate;
      // widget.list.add(automaticDateData);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        AutomaticDateList automaticDateList =
            Provider.of<AutomaticDateList>(context, listen: false);
        automaticDateList.items.add(automaticDateData);
        print(automaticDateList.getItems);
      });
    }
  }

  void onActivityChanged(Activity prevActivity, Activity currActivity) {
    dev.log('prevActivity: ${prevActivity.toMap()}');
    dev.log('currActivity: ${currActivity.toMap()}\n');
    activityController.sink.add(currActivity);
  }

  void onError(dynamic error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      dev.log('Undefined error: $error');
      return;
    }

    dev.log('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.stairs,
    Icons.bar_chart,
    Icons.person,
  ];

  final tabs = [
    HomeScreen(),
    ProjectsScreen(),
    StaticsScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Services>(context, listen: false);
    if (service.employerId != null) {
      service.getLocationsByEmployer().then((locations) {
        geofenceList.clear();
        for (var item in locations) {
          geofenceList.add(Geofence(
              id: item.locationName,
              latitude: item.locationLat,
              longitude: item.locationLon,
              data: item.locationId,
              radius: [GeofenceRadius(id: 'radius_25m', length: 100)]));
        }
        startGeofencing();
      });
    }
    WithForegroundService(
      geofenceService: geofenceService,
    );
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[300],
      body: tabs[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeColor: HexColor("#222C4A"),
        splashColor: HexColor("#222C4A"),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: service.projectId != null
          ? FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: HexColor("#222C4A"),
              disabledElevation: 1,
              onPressed: () {
                Navigator.of(context).pushNamed('/addTimeSheet_Screen');
              },
            )
          : null,
    );
  }
}
