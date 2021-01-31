import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
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
  static DatabaseHelper db;
  var tamanhoDaLista;
  List<Applications> list;

  void _nav() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ApplicationsScreen(tamanhoDaLista)),
    );
  }

  @override
  void initState() {
    super.initState();
    db = new DatabaseHelper();

    db.initDb();

    Future<List<Applications>> listFuture = db.getProds();
    listFuture.then((novalist) {
      setState(() {
        this.list = novalist;
        this.tamanhoDaLista = novalist.length;
      });
    });
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
