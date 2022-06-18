// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'dart:html';

// import 'dart:ffi';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pci/components/default_button.dart';
import 'package:pci/screens/third_screen/third_screen.dart';
import 'package:pci/sizeconfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pci/screens/third_screen/components/body.dart';
import 'package:calculus/calculus.dart';
import 'dart:math';
// import 'package:vector_math/vector_math.dart';
// import 'package:flutter/src/material/colors.dart';

class Body11 extends StatefulWidget {
  const Body11({Key? key}) : super(key: key);

  @override
  State<Body11> createState() => _Body11State();
}

class _Body11State extends State<Body11> {
  void getaccelerometervalues() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          z = event.z;
        });
      }
    });
  }

  getiri() {
    double integration = Calculus.integral(0, getDistance(), (p0) => z, 1);
    // double i = z * (getDistance() + 0);
    // double doublein = i * (1 + 0);
    double doubleintegration = Calculus.integral(0, 1, (p0) => integration, 1);
    iri = doubleintegration / getDistance();
  }

//Calculating the distance between two points with Geolocator plugin
  double getDistance() {
    double distance = Geolocator.distanceBetween(startgpsvaluelat,
        startgpsvaluelong, currentgpsvaluelat, currentgpsvaluelong);
    print(distance);
    return distance;
  }

  getgpsvalues() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //  Position position1 = await Geolocator.
    // print(position);
    startgpsvaluelat = position.latitude;
    startgpsvaluelong = position.longitude;
    // return [location, location11];
  }

  getstartgpsvalues() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    Position position1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position);
    startgpsvaluelat = position1.latitude;
    startgpsvaluelong = position1.longitude;
    // return [location, location11];
  }

  getcurrentgpsvalues() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    Position position2 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position);
    currentgpsvaluelat = position2.latitude;
    currentgpsvaluelong = position2.longitude;
    // return [location, location11];
  }

  storeinfirebase() {
    if (iri.isNaN == false) {
      _firestore.collection('IRIGPS').add({
        'IRI': iri,
        'Latitude': latitude,
        'Longitude': longitude,
        'createdOn': FieldValue.serverTimestamp(),
      });
    }
  }

  Timer? timer;
  Timer? timer1;

  @override
  void dispose() {
    timer?.cancel();
    timer1?.cancel();
    super.dispose();
  }

  double x = 0, y = 0, z = 0;
  double? latitude;
  double? longitude;

  final _firestore = FirebaseFirestore.instance;
  double iri = 0;
  double startgpsvaluelat = 1;
  double startgpsvaluelong = 1;
  double currentgpsvaluelat = 0;
  double currentgpsvaluelong = 0;
  // Timer? timer;
  getpositionstream() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      return;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();

      return;
    } else {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high, //accuracy of the location data
        distanceFilter: 0, //minimum distance (measured in meters) a
        //device must move horizontally before an update event is generated;
      );
      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        latitude = position.latitude.toDouble();
        longitude = position.longitude.toDouble();
        print('$longitude $latitude latitude longitude');
        currentgpsvaluelat = position.latitude.toDouble();
        currentgpsvaluelong = position.longitude.toDouble();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getpositionstream();
    getaccelerometervalues();
    getgpsvalues();
    // getstartgpsvalues();
    // getcurrentgpsvalues();
    getiri();
    getDistance();
    // getLocationUpdates();
    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => storeinfirebase());
    timer1 =
        Timer.periodic(Duration(seconds: 2), (Timer t) => getpositionstream());
    super.initState();
    // getLocation();
    //get the sensor data and set then to the data types
  }

  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {
        getaccelerometervalues();
        Column();
        // getLocationUpdates();
        // getLocation()
        getgpsvalues();
        getpositionstream();
        // getcurrentgpsvalues();
        getiri();
      });
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Text(
              "Click Stop When finish reading Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Image.asset(
              "assets/images/c7.png",
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            SpinKitThreeBounce(
              color: Color.fromARGB(255, 252, 151, 0),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              "IRI:${iri.toStringAsFixed(1)}",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(16),
              ),
            ),
            // Text(
            //   "GPS Longitude:${latitude!.toStringAsFixed(2)}",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: getProportionateScreenWidth(16),
            //   ),
            // ),
            // Text(
            //   "GPS Latitude:${longitude!.toStringAsFixed(2)}",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: getProportionateScreenWidth(16),
            //   ),
            // ),
            // SizedBox(
            //   height: getProportionateScreenHeight(30),
            // ),
            DefaultButton(
              text: "Stop",
              press: () {
                //getLocation();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Body()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
