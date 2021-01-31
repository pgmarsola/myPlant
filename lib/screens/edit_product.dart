import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_plant/helpers/db.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/screens/getpolygons.dart';
import 'package:my_plant/screens/products.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/form.dart';

class EditProduct extends StatefulWidget {
  final Position _position;
  final Applications applications;

  EditProduct(this.applications, this._position);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final dbHelper = DatabaseHelper();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _positionAnnotation;

  final _annotation = TextEditingController();

  final _date = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  bool value;

  @override
  void initState() {
    super.initState();
    _annotation.text = widget.applications.annotation;
    _date.text = widget.applications.dateApplication;
    value = widget.applications.application == 1 ? true : false;
  }

  _getLocationAnnotation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _positionAnnotation = position;
      });
    }).catchError((e) {
      final snackBar = SnackBar(
        content: Text('Erro ao buscar localização'),
      );
      Scaffold.of(context).showBottomSheet((context) => snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/plant.png',
          scale: 15,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: verde,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Products()),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: verde,
        foregroundColor: branco,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            Map<String, dynamic> row = {
              DatabaseHelper.columnCod: widget.applications.cod,
              DatabaseHelper.columnName: widget.applications.name,
              DatabaseHelper.columnDose: widget.applications.dose,
              DatabaseHelper.columnApplication: value == true ? 1 : 0,
              DatabaseHelper.columnDate: widget.applications.date,
              DatabaseHelper.columnAnnotation: _annotation.text,
              DatabaseHelper.columnDateApplication: _date.text,
              DatabaseHelper.columnPolygons: '_polygons',
              DatabaseHelper.columnLongB:
                  _positionAnnotation.longitude.toString(),
              DatabaseHelper.columnLatB:
                  _positionAnnotation.latitude.toString(),
            };
            final rowsAffected =
                await dbHelper.update(row, widget.applications.cod);
            print('updated $rowsAffected row(s)');

            _formKey.currentState.reset();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Products()),
            );
          }
        },
        icon: Icon(Icons.refresh),
        label: Text('Atualizar'.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenHeight * 2),
          child: new Form(
            key: _formKey,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Nome do produto: ${widget.applications.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 1.5,
                ),
                Text(
                  'Dosagem: ${widget.applications.dose}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 1.5,
                ),
                Text(
                  'Data para aplicação: ${widget.applications.date}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 1.5,
                ),
                CheckboxListTile(
                  title: Text("Marcar Aplicação"),
                  checkColor: branco,
                  activeColor: verde,
                  value: value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                      print(value);
                      if (value == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetPolygons(
                                  widget._position,
                                  widget.applications.cod.toString())),
                        );
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(
                  height: screenHeight * 1.5,
                ),
                FormText('Data da Aplicação', _date),
                SizedBox(
                  height: screenHeight * 1.5,
                ),
                FormText('Anotação', _annotation),
                RaisedButton.icon(
                  color: _positionAnnotation != null ? verde : vermelho,
                  onPressed: () {
                    _getLocationAnnotation();
                  },
                  label: Text(
                    _positionAnnotation != null
                        ? 'Localização Salva'
                        : 'Pegar Localização',
                    style: TextStyle(color: branco),
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: branco,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
