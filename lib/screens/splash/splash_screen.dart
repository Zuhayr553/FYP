// ignore_for_file: prefer_const_constructors, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:pci/sizeconfig.dart';
import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
