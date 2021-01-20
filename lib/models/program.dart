import 'package:my_plant/models/applications.dart';

class Program {
  String title;
  List<Applications> applications;

  Program({this.title, this.applications});

  Program.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['applications'] != null) {
      applications = <Applications>[];
      json['applications'].forEach((v) {
        applications.add(new Applications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.applications != null) {
      data['applications'] = this.applications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
