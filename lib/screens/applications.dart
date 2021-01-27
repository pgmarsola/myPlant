import 'package:flutter/material.dart';
import 'package:my_plant/screens/products.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/application_btn.dart';
import 'package:my_plant/widgets/bottombar.dart';
import 'package:my_plant/widgets/topbar.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  @override
  void initState() {
    super.initState();
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
      appBar: TopBar(),
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
