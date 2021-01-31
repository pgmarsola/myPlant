import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPolygons extends StatefulWidget {
  final Position location;
  final String id;
  GetPolygons(this.location, this.id);

  @override
  _GetPolygonsState createState() => _GetPolygonsState();
}

class _GetPolygonsState extends State<GetPolygons> {
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  List<String> stringpolygons = <String>[];
  double radius;

  int _polygonIdCounter = 1;

  bool _isPolygon = true;

  @override
  initState() {
    super.initState();
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs,
      strokeWidth: 2,
      strokeColor: verdeescuro,
      fillColor: verdeescuro.withOpacity(0.15),
    ));
  }

  Widget _fabPolygon() {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          polygonLatLngs.removeLast();
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Desfazer'),
      backgroundColor: vermelho,
    );
  }

  Widget _savePolygon() {
    return FloatingActionButton.extended(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          prefs.setStringList('${widget.id}', stringpolygons);
          print(stringpolygons);
        });
        Navigator.pop(context);
      },
      icon: Icon(Icons.save),
      label: Text('Salvar'),
      backgroundColor: verde,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return Scaffold(
      appBar: TopBar(),
      floatingActionButton: polygonLatLngs.length > 0 && _isPolygon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _savePolygon(),
                SizedBox(
                  width: screenHeight * 2,
                ),
                _fabPolygon(),
              ],
            )
          : null,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        mapType: MapType.hybrid,
        polygons: _polygons,
        myLocationEnabled: true,
        onTap: (point) {
          if (_isPolygon) {
            setState(() {
              polygonLatLngs.add(point);
              stringpolygons.add(point.toString());
              _setPolygon();
            });
          }
        },
      ),
    );
  }
}
