class Applications {
  int codApplication;
  String name;
  String dose;
  bool application;
  String date;
  String annotation;
  String dateApplication;

  Applications(
      {this.codApplication,
      this.name,
      this.dose,
      this.application,
      this.date,
      this.annotation,
      this.dateApplication});

  Applications.fromJson(Map<String, dynamic> json) {
    codApplication = json['codApplication'];
    name = json['name'];
    dose = json['dose'];
    application = json['application'];
    date = json['date'];
    annotation = json['annotation'];
    dateApplication = json['dateApplication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codApplication'] = this.codApplication;
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['application'] = this.application;
    data['date'] = this.date;
    data['annotation'] = this.annotation;
    data['dateApplication'] = this.dateApplication;
    return data;
  }
}
