// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pci/components/default_button.dart';
import 'package:pci/constants.dart';
import 'package:pci/screens/First_screen/first_screen.dart';
import 'package:pci/screens/Second_screen/components/body.dart';
import 'package:pci/screens/Second_screen/second_screen.dart';
import 'package:pci/sizeconfig.dart';
import 'package:pci/screens/Second_screen/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? Latitude;
  String? Longitude;
  double iri = 0;
  // final _firestore = FirebaseFirestore.instance;
  getdata() async {
    var collection = FirebaseFirestore.instance.collection('IRIGPS');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (mounted) {
        setState(() {
          iri = data['IRI'];
          Latitude = data['Latitude'];
          Longitude = data['Longitude'];
        });
      }
    }
  }

  // int iri = 0;
  void init() {
    getdata();
    Column();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {
        getdata();
        Column();
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Scaffold(
        //   backgroundColor: Colors.white,
        // ),
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            color: kPrimaryColor,
            child: ListTile(
              title: Text(
                "Results",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              trailing: Text(
                "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            color: kPrimaryColor,
            child: ListTile(
              title: Text(
                "IRI Value:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trailing: Text(
                iri.toStringAsFixed(1),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(16),
        //   child: Card(
        //     color: kPrimaryColor,
        //     child: ListTile(
        //       title: Text(
        //         "GPS:",
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //             color: Colors.black),
        //       ),
        //       trailing: Text(
        //         "Longitude: $Latitude Latitude: $Longitude",
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 17,
        //             color: Colors.black),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            color: kPrimaryColor,
            child: ListTile(
              title: Text(
                "Road Condition:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trailing: Text(
                "Poor",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(40),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: DefaultButton(
            text: "Start a new Survey",
            press: () {
              // if (iri == 0) {
              //   _firestore.collection('IRI').add({
              //     'IRI': iri,
              //     'Road Condition': 'Poor',
              //     'GPS Longitude': Latitude,
              //     'GPS Latitude': Longitude
              //   });
              //   _firestore.collection('GPS').add(
              //       {'GPS Longitude': Latitude, 'GPS Latitude': Longitude});
              // }
              Navigator.of(context).pushNamed(FirstScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
