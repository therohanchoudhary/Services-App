import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/screens/app_home_screen.dart';
import 'package:service_app/register_and_login/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                FirebaseAuth.instance.currentUser == null
                    ? HomeScreen()
                    : AppHomeScreen())));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              height: height - 20,
              width: width - 20,
              child: Image.asset('assets/images/serviceMan.jpg')),
        ));
  }
}
