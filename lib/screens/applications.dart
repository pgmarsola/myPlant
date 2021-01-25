import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/screens/products.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/application_btn.dart';
import 'package:my_plant/widgets/bottombar.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'dart:async';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  static DatabaseHelper dbHelper;
  int tamanhoDaLista = 0;
  List<Applications> listaProdutos;

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  _carregarLista() async {
    dbHelper = DatabaseHelper.instance;
    Future<List<Applications>> prods = dbHelper.getProds();
    prods.then((novaListaProdutos) {
      setState(() {
        this.listaProdutos = novaListaProdutos;

        this.tamanhoDaLista = novaListaProdutos.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    void _nav(List<Applications> list, int tamanho) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Products(list, tamanho)),
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
                _nav(
                  listaProdutos,
                  tamanhoDaLista,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
