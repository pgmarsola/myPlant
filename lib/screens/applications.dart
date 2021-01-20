import 'package:flutter/material.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/application_btn.dart';
import 'package:my_plant/widgets/topbar.dart';

class Applications extends StatefulWidget {
  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

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
            ApplicationBtn('Aplicação 1', () {}),
            ApplicationBtn('Aplicação 2', () {}),
            ApplicationBtn('Aplicação 3', () {}),
          ],
        ),
      ),
    );
  }
}
