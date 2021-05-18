import 'dart:convert';

List<AllProjectTime> allProjectTimeFromJson(String str) =>
    List<AllProjectTime>.from(
        json.decode(str).map((x) => AllProjectTime.fromJson(x)));

String allProjectTimeToJson(List<AllProjectTime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProjectTime {
  AllProjectTime({
    this.name,
    this.totaal,
  });

  String name;
  double totaal;

  factory AllProjectTime.fromJson(Map<String, dynamic> json) => AllProjectTime(
        name: json["project_name"],
        totaal: json["totaal"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "totaal": totaal,
      };
}
