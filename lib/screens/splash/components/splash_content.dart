// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../sizeconfig.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);
  final String image, text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          " Pavement Condition\n    Index Monitoring",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF000000)),
        ),
        Spacer(
            // flex: 2,
            ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(260),
          width: getProportionateScreenWidth(280),
        )
      ],
    );
  }
}
