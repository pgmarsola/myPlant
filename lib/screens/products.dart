import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/screens/maps.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_product.dart';

class Products extends StatefulWidget {
  Products();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _position;

  static DatabaseHelper db;
  int tamanhoDaLista = 0;
  List<Applications> listaProdutos;
  List<String> listaPrefs = <String>[];
  SharedPreferences list;

  @override
  void initState() {
    super.initState();
    _carregarLista();
    _getPrefs();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _position = position;
      });
    }).catchError((e) {
      final snackBar = SnackBar(
        content: Text('Erro ao buscar localização'),
      );
      Scaffold.of(context).showBottomSheet((context) => snackBar);
    });
  }

  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs;
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
        MaterialPageRoute(
            builder: (context) => EditProduct(applications, _position)),
      );
    }

    void _maps(Applications applications) {
      setState(() {
        listaPrefs = list.getStringList(applications.cod.toString());
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Maps(listaPrefs, applications.longB, applications.latB)),
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
                          child: Card(
                            child: listaProdutos[index].application == 1
                                ? Column(
                                    children: [
                                      ListTile(
                                        title: Text(listaProdutos[index].name),
                                        subtitle: Text(
                                          'Aplicado em: ${listaProdutos[index].dateApplication}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: verde),
                                        ),
                                        leading: CircleAvatar(
                                          child: Icon(
                                            Icons.check,
                                            color: verde,
                                          ),
                                          backgroundColor: amarelo,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 1.5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: verde,
                                            ),
                                            SizedBox(width: screenHeight * 1.5),
                                            Text(
                                              'Clique para ver o mapa',
                                              style: TextStyle(color: chumbo),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : ListTile(
                                    title: Text(listaProdutos[index].name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Aplicação prevista: ${listaProdutos[index].date}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: vermelho),
                                        ),
                                      ],
                                    ),
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                        'assets/plant.png',
                                        scale: screenHeight * 2,
                                      ),
                                      backgroundColor: amarelo,
                                    ),
                                  ),
                            elevation: 5.0,
                            margin: EdgeInsets.all(screenHeight * 2),
                          ),
                          onTap: listaProdutos[index].application == 0
                              ? () => _nav(listaProdutos[index])
                              : () => _maps(listaProdutos[index]),
                        );
                      },
                    ),
                  )
                ])));
  }
}
