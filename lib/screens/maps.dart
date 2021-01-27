import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_plant/widgets/topbar.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  List<Marker> allMarkers = [];
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
        ),
        'assets/apply.png');
    if (pinLocationIcon != null) {
      allMarkers.add(Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          onTap: () {
            print('Marker tapped');
          },
          position: LatLng(-22.8840920391068, -47.06619471116141)));
      allMarkers.add(Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          onTap: () {
            print('Marker tapped');
          },
          position: LatLng(-22.884305, -47.067053),
          icon: pinLocationIcon));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(-22.8840920391068, -47.06619471116141),
                zoom: 12),
            markers: Set.from(allMarkers),
          ),
        ),
      ),
    );
  }
}
