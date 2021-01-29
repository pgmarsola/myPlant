import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'edit_product.dart';

class Products extends StatefulWidget {
  Products();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  static DatabaseHelper db;
  int tamanhoDaLista = 0;
  List<Applications> listaProdutos;

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  _carregarLista() async {
    db = DatabaseHelper();
    Future<List<Applications>> prods = db.getProds();
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

    void _nav(Applications applications) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EditProduct(applications)),
      );
    }

    return Scaffold(
        backgroundColor: verdeclaro,
        appBar: TopBar(),
        body: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: tamanhoDaLista,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ListTile(
                            title: Text(listaProdutos[index].name),
                            subtitle: Text(listaProdutos[index].dose),
                            leading: CircleAvatar(
                              child: Text(
                                  listaProdutos[index].application.toString()),
                              backgroundColor: amarelo,
                            ),
                          ),
                          onTap: () => _nav(listaProdutos[index]),
                        );
                      },
                    ),
                  )
                ])));
  }
}
