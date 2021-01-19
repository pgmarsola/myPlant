import 'package:flutter/material.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/program_btn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeclaro,
      appBar: AppBar(
        title: Image.asset(
          "assets/planet-earth.png",
          height: 31,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text('teste'),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgramBtn("assets/planet-earth.png", 'programa 1', () {})
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
