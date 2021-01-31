class Applications {
  int cod;
  String name;
  String dose;
  int application;
  String date;
  String annotation;
  String dateApplication;
  String polygons;
  String longB;
  String latB;

  Applications({
    this.cod,
    this.name,
    this.dose,
    this.application,
    this.date,
    this.annotation,
    this.dateApplication,
    this.polygons,
    this.longB,
    this.latB,
  });

  Applications.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    name = json['name'];
    dose = json['dose'];
    application = json['application'];
    date = json['date'];
    annotation = json['annotation'];
    dateApplication = json['dateApplication'];
    polygons = json['polygons'];
    longB = json['longB'];
    latB = json['latB'];
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
    data['polygons'] = this.polygons;
    data['longB'] = this.longB;
    data['latB'] = this.latB;
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
  static String columnPolygons = "polygons";
  static String columnLongB = "longB";
  static String columnLatB = "latB";

  Applications.fromMap(Map map) {
    cod = map[columnId];
    cod = map[columnCod];
    name = map[columnName];
    dose = map[columnDose];
    application = map[columnApplication];
    date = map[columnDate];
    annotation = map[columnAnnotation];
    dateApplication = map[columnDateApplication];
    polygons = map[columnPolygons];
    longB = map[columnLongB];
    latB = map[columnLatB];
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
      columnPolygons: polygons,
      columnLongB: longB,
      columnLatB: latB,
    };
    return map;
  }
}
