import 'package:my_plant/models/a.dart';

class Applications {
  List<A> a1;
  List<A> a2;
  List<A> a3;

  Applications({this.a1, this.a2, this.a3});

  Applications.fromJson(Map<String, dynamic> json) {
    if (json['a1'] != null) {
      a1 = <A>[];
      json['a1'].forEach((v) {
        a1.add(new A.fromJson(v));
      });
    }
    if (json['a2'] != null) {
      a2 = <A>[];
      json['a2'].forEach((v) {
        a2.add(new A.fromJson(v));
      });
    }
    if (json['a3'] != null) {
      a3 = <A>[];
      json['a3'].forEach((v) {
        a3.add(new A.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a1 != null) {
      data['a1'] = this.a1.map((v) => v.toJson()).toList();
    }
    if (this.a2 != null) {
      data['a2'] = this.a2.map((v) => v.toJson()).toList();
    }
    if (this.a3 != null) {
      data['a3'] = this.a3.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
