class Applications {
  int cod;
  String name;
  String dose;
  int application;
  String date;
  String annotation;
  String dateApplication;

  Applications(
      {this.cod,
      this.name,
      this.dose,
      this.application,
      this.date,
      this.annotation,
      this.dateApplication});

  Applications.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    name = json['name'];
    dose = json['dose'];
    application = json['application'];
    date = json['date'];
    annotation = json['annotation'];
    dateApplication = json['dateApplication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this.cod;
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['application'] = this.application;
    data['date'] = this.date;
    data['annotation'] = this.annotation;
    data['dateApplication'] = this.dateApplication;
    return data;
  }

  static String table = "tabela_application";
  static String columnId = "cod";
  static String columnCod = "cod";
  static String columnName = "name";
  static String columnDose = "dose";
  static String columnApplication = "application";
  static String columnDate = "date";
  static String columnAnnotation = "annotation";
  static String columnDateApplication = "dateApplication";

  Applications.fromMap(Map map) {
    cod = map[columnId];
    cod = map[columnCod];
    name = map[columnName];
    dose = map[columnDose];
    application = map[columnApplication];
    date = map[columnDate];
    annotation = map[columnAnnotation];
    dateApplication = map[columnDateApplication];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      columnId: cod,
      columnCod: cod,
      columnName: name,
      columnDose: dose,
      columnApplication: application,
      columnDate: date,
      columnAnnotation: annotation,
      columnDateApplication: dateApplication,
    };
    return map;
  }
}
