// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pci/components/default_button.dart';
import 'package:pci/maps1.dart';
import 'package:pci/screens/Second_screen/second_screen.dart';
import 'package:pci/sizeconfig.dart';
import 'package:pci/screens/Second_screen/components/body.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
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
                "Start recording accelerometer data by clicking on \n'Start Driving'",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(16),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Image.asset("assets/images/c5.png"),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              DefaultButton(
                text: "Start Driving",
                press: () {
                  // getLocation();
                  Navigator.pushNamed(context, SecondScreen.routeName);
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              DefaultButton(
                text: "Maps",
                press: () {
                  // getLocation();
                  Navigator.pushNamed(context, Maps.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
