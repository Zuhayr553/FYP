// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pci/screens/First_screen/first_screen.dart';
import 'package:pci/screens/Forgot_Password/forgot_screen.dart';
import 'package:pci/screens/Second_screen/second_screen.dart';
import 'package:pci/screens/SignIn/signin_screen.dart';
import 'package:pci/screens/signup/signup_screen.dart';
import 'package:pci/screens/splash/splash_screen.dart';
import 'package:pci/screens/third_screen/third_screen.dart';
import 'maps.dart';
import 'maps1.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotScreen.routneName: (context) => ForgotScreen(),
  SignupScreen.routenName: (context) => SignupScreen(),
  FirstScreen.routeName: (context) => FirstScreen(),
  SecondScreen.routeName: (context) => SecondScreen(),
  ThirdScreen.routeName: (context) => ThirdScreen(),
  Maps.routeName: (context) => Maps(),
};
