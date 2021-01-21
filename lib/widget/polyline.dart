import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  static String routeName = 'polyline-google-map-screen';
  @override
  _PolyLineScreenState createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(12.988827, 77.472091), zoom: 13);
  Set<Polyline> lines = {};

  @override
  void initState() {
    super.initState();
    lines.add(
      Polyline(
        points: [
          LatLng(12.988827, 77.472091),
          LatLng(12.980821, 77.470815),
        ],
        endCap: Cap.squareCap,
        geodesic: false,
        polylineId: PolylineId("line_one"),
      ),
    );
    lines.add(
      Polyline(
        points: [LatLng(12.949798, 77.470534), LatLng(12.938614, 77.469379)],
        color: Colors.amber,
        polylineId: PolylineId("line_one"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polylines: lines,
      ),
    );
  }
}
