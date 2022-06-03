// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:pci/sizeconfig.dart';

import 'components/body.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);
  static String routneName = "/forgot_pass";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.black,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
