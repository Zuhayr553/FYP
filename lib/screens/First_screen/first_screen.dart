// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pci/sizeconfig.dart';

import 'components/body.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  static String routeName = "/first_screen";
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
      body: Body(),
    );
  }
}
