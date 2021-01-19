import 'package:flutter/material.dart';
import 'package:service_app/register_and_login/welcome_screen.dart';

import '../utility/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height / 25),
              Text('Welcome to the Uclab Service App',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: height / 40),
              Image.asset('assets/images/serviceMan.jpg'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WelcomeScreen())),
                child: Container(
                    height: 70,
                    width: width / 1.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width),
                        color: HexColor("04D337")),
                    child: Center(
                        child: Text('I am a customer',
                            style: TextStyle(color: Colors.white,fontSize: 18)))),
              ),
              SizedBox(height: height / 20),
              GestureDetector(
                child: Container(
                    height: 70,
                    width: width / 1.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width),
                        color: HexColor("04D337")),
                    child: Center(
                        child: Text('I am a service provider',
                            style: TextStyle(color: Colors.white,fontSize: 18)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
