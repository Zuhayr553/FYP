// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pci/sizeconfig.dart';

import 'components/body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static String routenName = "/signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
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
