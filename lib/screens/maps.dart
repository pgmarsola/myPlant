import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';

class Maps extends StatefulWidget {
  final List<String> polygons;
  final String longB;
  final String latB;

  Maps(this.polygons, this.longB, this.latB);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  List<Marker> allMarkers = [];
  List<Polygon> allPolygons = [];
  List<LatLng> position = [];
  String name = '';

  @override
  void initState() {
    super.initState();
    setPin();
  }

  void setPin() {
    if (widget.polygons.length != 0) {
      for (int i = 0; i < widget.polygons.length; i++) {
        var value = widget.polygons[i].replaceAll('LatLng', '');
        var a = value.replaceAll('(', '');
        var b = a.replaceAll(')', '');
        var c = b.split(', ');
        position.add(LatLng(double.parse(c[0]), double.parse(c[1])));
      }
    }

    allPolygons.add(Polygon(
        polygonId: PolygonId('value'),
        points: position,
        strokeWidth: 2,
        strokeColor: verdeescuro,
        fillColor: verdeescuro.withOpacity(0.15),
        onTap: () {
          setState(() {
            name = 'Ponto da aplicação';
          });
        }));

    allMarkers.add(Marker(
        markerId: MarkerId('Anotação'),
        consumeTapEvents: true,
        draggable: false,
        onTap: () {
          setState(() {
            name = 'Ponto da anotação';
          });
        },
        position:
            LatLng(double.parse(widget.latB), double.parse(widget.longB))));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(widget.latB), double.parse(widget.longB)),
                  zoom: 16),
              markers: Set.from(allMarkers),
              polygons: Set.from(allPolygons),
            ),
          ),
          name != null && name.isNotEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    color: branco.withOpacity(0.9),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: verde,
                          ),
                          SizedBox(width: screenHeight * 1.5),
                          Text(
                            name,
                            style: TextStyle(
                                color: verde, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.all(screenHeight * 2),
                  ),
                )
              : SizedBox.shrink()
        ],
      )),
    );
  }
}
