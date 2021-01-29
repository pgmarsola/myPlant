import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/mobx_estruture/data.controller.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/screens/home.dart';
import 'package:my_plant/screens/products.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/application_btn.dart';
import 'package:my_plant/widgets/bottombar.dart';
import 'package:my_plant/widgets/topbar.dart';

class ApplicationsScreen extends StatefulWidget {
  final tamanho;

  ApplicationsScreen(this.tamanho);

  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  ProgramController _programController;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    _programController = ProgramController();
    super.initState();
    _populeDB();
  }

  void _insert(Applications data) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnCod: data.cod,
      DatabaseHelper.columnName: data.name,
      DatabaseHelper.columnDose: data.dose,
      DatabaseHelper.columnApplication: data.application,
      DatabaseHelper.columnDate: data.date,
      DatabaseHelper.columnAnnotation: data.annotation,
      DatabaseHelper.columnDateApplication: data.dateApplication,
      DatabaseHelper.columnLongA: data.longA,
      DatabaseHelper.columnLatA: data.latA,
      DatabaseHelper.columnLongB: data.longB,
      DatabaseHelper.columnLatB: data.latB,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  _populeDB() async {
    await _programController.fetchPrograms();

    if (widget.tamanho == 0) {
      for (int i = 0; i < _programController.application.length; i++) {
        _insert(_programController.application[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    void _nav() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Products()),
      );
    }

    return Scaffold(
      backgroundColor: verdeclaro,
      appBar: AppBar(
        title: Image.asset(
          'assets/plant.png',
          scale: 15,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: verde,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            }),
      ),
      bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(screenHeight * 5),
              child: Text(
                'Nome do Programa',
                textAlign: TextAlign.center,
                style: TextStyle(color: chumbo, fontWeight: FontWeight.w500),
              ),
            ),
            ApplicationBtn(
              'Aplicação 1',
              () {
                _nav();
              },
            )
          ],
        ),
      ),
    );
  }
}
