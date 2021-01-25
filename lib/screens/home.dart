import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/mobx_estruture/data.controller.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/screens/applications.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/program_btn.dart';
import 'package:my_plant/widgets/topbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProgramController _programController;
  final dbHelper = DatabaseHelper.instance;

  void _nav() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApplicationsScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _programController = ProgramController();
    _populeDB();
  }

  void _insert(Applications data) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: data.name,
      DatabaseHelper.columnDose: data.dose,
      DatabaseHelper.columnApplication: data.application,
      DatabaseHelper.columnDate: data.date,
      DatabaseHelper.columnAnnotation: data.annotation,
      DatabaseHelper.columnDateApplication: data.dateApplication,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  _populeDB() async {
    await _programController.fetchPrograms();
    for (int i = 0; i < _programController.application.length; i++) {
      _insert(_programController.application[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    List<Widget> list = List.generate(4, (index) {
      return Column(
        children: [
          ProgramBtn("assets/planet-earth.png", 'programa $index', () {
            _nav();
          }),
        ],
      );
    });

    return Scaffold(
      backgroundColor: verdeclaro,
      appBar: TopBar(),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('teste'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(screenHeight * 5),
              child: Text(
                'Programas Disponíveis',
                textAlign: TextAlign.center,
                style: TextStyle(color: chumbo, fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: list,
            )
          ],
        ),
      ),
    );
  }
}
