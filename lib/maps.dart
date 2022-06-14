import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  var Latitude = [];
  var Longitude = [];
  var iri = [];
  List<LatLng> latlang = [];
  Map<String, dynamic> data = Map();

  String googleAPiKey = "AIzaSyDhVYvymMmOI4B7z5SGnpTvmyNbBp_1QOo";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(34.020660, 71.495093);
  LatLng endLocation = LatLng(34.034364, 71.480534);

  @override
  void initState() {
    getdata();

    markers
        .addLabelMarker(LabelMarker(
      label: "Starting Point",
      markerId: MarkerId(startLocation.toString()),
      position: startLocation,
      backgroundColor: Colors.deepPurpleAccent,
    ))
        .then(
      (value) {
        setState(() {});
      },
    );
    markers
        .addLabelMarker(LabelMarker(
      label: "End Point",
      markerId: MarkerId(endLocation.toString()),
      position: endLocation,
      backgroundColor: Colors.deepPurpleAccent,
    ))
        .then(
      (value) {
        setState(() {});
      },
    );
    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getdata() async {
    var collection = FirebaseFirestore.instance
        .collection('IRIGPS')
        .where("IRI", isGreaterThan: 8);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      data = queryDocumentSnapshot.data();
      // print(data);
      iri.add(data['IRI']);
      Latitude.add(data['Latitude']);
      Longitude.add(data['Longitude']);
      markers
          .addLabelMarker(LabelMarker(
        label:
            "IRI:${data['IRI']} Lat:${data['Latitude']} Long:${data['Longitude']}",
        markerId: MarkerId("Bad IRI"),
        position: LatLng(
            double.parse(data['Latitude']), double.parse(data['Longitude'])),
        backgroundColor: Color.fromARGB(255, 6, 2, 252),
      ))
          .then(
        (value) {
          setState(() {});
        },
      );
      // latlang.add(LatLng(data['Latitude'], data['Longitude']));
    }
    print(markers);
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: startLocation, //initial position
          zoom: 16.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        polylines: Set<Polyline>.of(polylines.values), //polylines
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
