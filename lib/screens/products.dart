import 'package:flutter/material.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Products extends StatefulWidget {
  Products();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  static DatabaseHelper dbHelper;
  int tamanhoDaLista = 0;
  List<Applications> listaProdutos;
  var conta = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  _carregarLista({int value}) async {
    dbHelper = DatabaseHelper.instance;
    Future<List<Applications>> prods = dbHelper.getProds();
    prods.then((novaListaProdutos) {
      setState(() {
        this.listaProdutos = novaListaProdutos;

        this.tamanhoDaLista = novaListaProdutos.length;

        var valor = 1 / this.tamanhoDaLista;

        if (conta == null) {
          conta = valor;
        } else if (value == 1 && conta != 1) {
          conta = conta + valor;
        } else if (value == 0 && conta != 0) {
          conta = conta - valor;
        }
      });
    });
  }

  final _aplicado = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    Widget campoDeNome() {
      return new TextFormField(
        controller: _aplicado,
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
          hintText: 'Nome',
          labelText: 'Nome completo',
          border: OutlineInputBorder(),
        ),
      );
    }

    void _update(Applications applications) {
      _aplicado.text = applications.application.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atualizar Contato"),
            content: new Container(
              child: new Form(
                key: _formKey,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    campoDeNome(),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Atualizar"),
                onPressed: () async {
                  // faz a validacao do formulario
                  if (_formKey.currentState.validate()) {
                    Map<String, dynamic> row = {
                      DatabaseHelper.columnCod: applications.cod,
                      DatabaseHelper.columnName: applications.name,
                      DatabaseHelper.columnDose: applications.dose,
                      DatabaseHelper.columnApplication:
                          int.parse(_aplicado.text),
                      DatabaseHelper.columnDate: applications.date,
                      DatabaseHelper.columnAnnotation: applications.annotation,
                      DatabaseHelper.columnDateApplication:
                          applications.dateApplication,
                    };
                    final rowsAffected =
                        await dbHelper.update(row, applications.cod);
                    print('updated $rowsAffected row(s)');

                    //carrego a lista com os novos valores
                    _carregarLista(value: int.parse(_aplicado.text));

                    //reseto os campos do formulario
                    _formKey.currentState.reset();

                    // retiro o alerta da tela
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
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
                  Container(
                    height: screenHeight * 10,
                    width: size.width,
                    child: Column(
                      children: [
                        Text(
                          'Progresso das aplicações'.toUpperCase(),
                          style: TextStyle(
                              color: chumbo, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 1.5),
                            child: new LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2500,
                              percent: conta == null ? 0 : conta,
                              center: conta == 1
                                  ? Text(
                                      'Concluído',
                                      style: TextStyle(color: branco),
                                    )
                                  : SizedBox.shrink(),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: conta == 1 ? verdeescuro : amarelo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          onTap: () => _update(listaProdutos[index]),
                        );
                      },
                    ),
                  )
                ])));
  }
}
