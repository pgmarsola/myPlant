import 'package:flutter/material.dart';
import 'package:my_plant/mobx_estruture/data.controller.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/application_btn.dart';
import 'package:my_plant/widgets/topbar.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  ProgramController _programController;

  @override
  void initState() {
    super.initState();
    _programController = ProgramController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    List<Applications> a1 =
        _programController.application.where((i) => i.codApplication == 1);
    List<Applications> a2 =
        _programController.application.where((i) => i.codApplication == 2);
    List<Applications> a3 =
        _programController.application.where((i) => i.codApplication == 0);

    return Scaffold(
      backgroundColor: verdeclaro,
      appBar: TopBar(),
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
            ApplicationBtn('Aplicação 1', () {}, a1),
            ApplicationBtn('Aplicação 2', () {}, a2),
            ApplicationBtn('Aplicação 3', () {}, a3),
          ],
        ),
      ),
    );
  }
}
