import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'dart:math' show cos, sqrt, asin;

class MapScreen extends StatefulWidget {
  static String routeName = 'map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  // start the initial part of the map
  // driver's place
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  // other user's place
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 30,
      zoom: 19.151926040649414);

// go to the other users place
  Future<void> _goToPlace() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

// end the initial part of the map

// start the adding markers to the map
  Set<Marker> markers = {};

  Marker startMarker = Marker(
    markerId: MarkerId('marker_one'),
    position: LatLng(37.42796133580664, -122.085749655962),
    infoWindow: InfoWindow(
      title: 'Start',
      snippet: 'driver place',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker destinationMarker = Marker(
    markerId: MarkerId('marker_two'),
    position: LatLng(37.43296265331129, -122.08832357078792),
    infoWindow: InfoWindow(
      title: 'Destination',
      snippet: 'mechanic place',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
// end the adding markers to the map

// start the adding markers to the map
  Set<Polyline> lines = {};

  ///// polyline start
  PolylinePoints polylinePoints;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  // Map storing polylines created by connecting two points

  Map<PolylineId, Polyline> polylines = {};
  ////// polyline ends

  _createPolylines() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDmno8-8jbPOH50GcUiM0qvgM0Qum50Yvo', // Google Maps API Key
      PointLatLng(37.42796133580664, -122.085749655962),
      PointLatLng(37.43296265331129, -122.08832357078792),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

// end the adding markers to the map

// start the distance calculating part
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double totalDistance = 0.0;
  String _placeDistance;
  var count = 0;

// Calculating the total distance by adding the distance
// between small segments
  _distanceBetweenTwoSegments() {
    totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

// Storing the calculated total distance of the route
    _placeDistance = totalDistance.toStringAsFixed(2);
  }

  // end the distance calculating part

  @override
  void initState() {
    super.initState();

    // adding polyline
    lines.add(
      Polyline(
        points: [
          LatLng(37.42796133580664, -122.085749655962),
          LatLng(37.43296265331129, -122.08832357078792),
        ],
        endCap: Cap.squareCap,
        geodesic: false,
        polylineId: PolylineId("line_one"),
      ),
    );

    // adding markers
    markers.add(startMarker);
    markers.add(destinationMarker);
  }

  _takeAllNeeded() {
    _createPolylines();
    _distanceBetweenTwoSegments();
  }

  @override
  Widget build(BuildContext context) {
    _takeAllNeeded();
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        polylines: Set<Polyline>.of(polylines.values),

        // polylines: lines,
        markers: markers != null ? Set<Marker>.from(markers) : null,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (count > 0) {
            return;
          }
          count++;
          setState(() {});
          _goToPlace();
        },
        label: _placeDistance == '0.00'
            ? Text('Find the place')
            : Text('$_placeDistance km'),
        icon: Icon(Icons.multiline_chart),
      ),
    );
  }
}
