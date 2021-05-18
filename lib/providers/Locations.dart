import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Locations> locationsFromJson(String str) =>
    List<Locations>.from(json.decode(str).map((x) => Locations.fromJson(x)));

String locationsToJson(List<Locations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Locations extends ChangeNotifier {
  Locations({
    this.locationId,
    this.locationName,
    this.locationLat,
    this.locationLon,
    this.radius,
  });

  String locationId;
  String locationName;
  double locationLat;
  double locationLon;
  int radius;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        locationId: json["locationId"],
        locationName: json["locationName"],
        locationLat: json["locationLat"].toDouble(),
        locationLon: json["locationLon"].toDouble(),
        radius: json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "locationName": locationName,
        "locationLat": locationLat,
        "locationLon": locationLon,
        "radius": radius,
      };

  @override
  String toString() {
    return locationName + " " + locationId.toString();
  }
}
