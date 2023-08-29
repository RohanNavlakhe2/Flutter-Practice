import 'package:artivatic_task/model/rows.dart';

class HomeData {
  String? title;
  List<ItemRow>? rows;

  HomeData({this.title, this.rows});

  HomeData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['rows'] != null) {
      rows = <ItemRow>[];
      json['rows'].forEach((v) {
        rows!.add(new ItemRow.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}