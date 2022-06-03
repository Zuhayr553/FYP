import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pci/main.dart';
import 'maps.dart';
import 'package:pci/sizeconfig.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);
  static String routeName = "maps1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Maps",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
      ),
      body: MapsHome(),
    );
  }
}
