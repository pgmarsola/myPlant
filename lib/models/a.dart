class A {
  String name;
  String dose;
  bool application;
  String date;
  String annotation;
  String dateApplication;

  A(
      {this.name,
      this.dose,
      this.application,
      this.date,
      this.annotation,
      this.dateApplication});

  A.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dose = json['dose'];
    application = json['application'];
    date = json['date'];
    annotation = json['annotation'];
    dateApplication = json['dateApplication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['application'] = this.application;
    data['date'] = this.date;
    data['annotation'] = this.annotation;
    data['dateApplication'] = this.dateApplication;
    return data;
  }
}
