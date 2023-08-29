// To parse this JSON data, do
//
//     final timeStampModel = timeStampModelFromJson(jsonString);

import 'dart:convert';

TimeStampModel timeStampModelFromJson(String str) => TimeStampModel.fromJson(json.decode(str));

String timeStampModelToJson(TimeStampModel data) => json.encode(data.toJson());

class TimeStampModel {
  TimeStampModel({
    this.id,
    this.timestamp,
  });

  int id;
  String timestamp;

  factory TimeStampModel.fromJson(Map<String, dynamic> json) => TimeStampModel(
    id: json["id"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timestamp": timestamp,
  };
}
