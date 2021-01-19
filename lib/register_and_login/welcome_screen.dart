import 'package:flutter/material.dart';
import 'package:service_app/register_and_login/login_screen.dart';
import 'package:service_app/register_and_login/register_screen.dart';

import '../utility/hexcolor.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  style: TextStyle(fontSize: 14)),
              SizedBox(height: height / 40),
              Text('Order, Get Work & Easy Pay',
                  style: TextStyle(fontSize: 12)),
              SizedBox(height: height / 5),
              Image.asset('assets/images/laptopMachine.jpg'),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegisterScreen())),
                    child: Container(
                        height: 70,
                        width: width / 2.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width),
                            color: HexColor("04D337")),
                        child: Center(
                            child: Text('Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)))),
                  ),
                  Flexible(child: SizedBox(width: 30)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen())),
                    child: Container(
                        height: 70,
                        width: width / 2.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width),
                            color: HexColor("04D337")),
                        child: Center(
                            child: Text('LOG IN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
