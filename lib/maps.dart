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
    //   markers.add(Marker(
    //     //add start location marker
    //     markerId: MarkerId(startLocation.toString()),
    //     position: startLocation, //position of marker
    //     infoWindow: InfoWindow(
    //       //popup info
    //       title: 'Starting Point',
    //       snippet: 'Start Marker',
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueBlue), //Icon for Marker
    //   ));

    //   markers.add(Marker(
    //     //add distination location marker
    //     markerId: MarkerId(endLocation.toString()),
    //     position: endLocation, //position of marker
    //     infoWindow: InfoWindow(
    //       //popup info
    //       title: 'Destination Point ',
    //       snippet: 'Destination Marker',
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueRed), //Icon for Marker
    //   )
    // );
    markers
        .addLabelMarker(LabelMarker(
      label: "Starting Point",
      markerId: MarkerId(startLocation.toString()),
      position: startLocation,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ))
        .then(
      (value) {
        setState(() {});
      },
    );
    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  // setmarker() {
  //   for (int i = 1; i <= Latitude.length; i++) {
  //     markers
  //         .addLabelMarker(LabelMarker(
  //       label: "IRI:${iri} Lat:${Latitude} Long:${Longitude}",
  //       markerId: MarkerId(endLocation.toString()),
  //       position: LatLng(double.parse(Latitude[i]), double.parse(Longitude[i])),
  //       backgroundColor: Color.fromARGB(255, 0, 0, 0),
  //     ))
  //         .then(
  //       (value) {
  //         setState(() {});
  //       },
  //     );
  //   }
  // }

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
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ))
          .then(
        (value) {
          setState(() {});
        },
      );
      // latlang.add(LatLng(data['Latitude'], data['Longitude']));
    }
    print(markers);
    // print(Latitude);
    // var list = [];
    // for (int i = 0; i <= querySnapshot.docs.length; i++) {
    //   if (mounted) {
    //     setState(() {
    //       data.forEach((key, value) {
    //         list.add();
    //         print(iri);
    //       });
    //     });
    //   }
    // }
    // for (int i = 0; i <= Latitude.length; i++) {
    //   latlang.add(LatLng(Latitude[i], Longitude[i]));
    // }
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
