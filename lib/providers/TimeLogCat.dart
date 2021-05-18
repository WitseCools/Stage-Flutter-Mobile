import 'dart:convert';

List<TimeLogCat> timelogCatFromjson(String str) =>
    List<TimeLogCat>.from(json.decode(str).map((x) => TimeLogCat.fromJson(x)));

String timelogCatToJson(List<TimeLogCat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeLogCat {
  TimeLogCat({
    this.timelogCatId,
    this.name,
  });

  String timelogCatId;
  String name;

  factory TimeLogCat.fromJson(Map<String, dynamic> json) => TimeLogCat(
        timelogCatId: json["timelogCatId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "timelogCatId": timelogCatId,
        "name": name,
      };
}
