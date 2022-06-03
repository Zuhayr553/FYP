// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pci/sizeconfig.dart';

import 'components/body.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);
  static String routeName = "/second-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PCI Monitoring",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
      ),
      body: Body11(),
    );
  }
}
