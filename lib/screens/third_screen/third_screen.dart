// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../sizeconfig.dart';
import 'components/body.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);
  static String routeName = "third-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Results",
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
