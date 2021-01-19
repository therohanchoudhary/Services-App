import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/utility/hexcolor.dart';
import 'package:service_app/utility/useful_methods.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailEntered = TextEditingController();
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: HexColor("04D337"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset("assets/images/forgotPassword.jpg"),
              SizedBox(height: 40),
              inputTextField("Enter Email ID", 80, 1,
                  TextInputType.emailAddress, _emailEntered, false),
              SizedBox(height: 40),
              _showSpinner == true
                  ? CircularProgressIndicator()
                  : GestureDetector(
                onTap: () async {
                  setState(() {
                    _showSpinner = true;
                  });

                  if (_emailEntered.text == null || _emailEntered.text == "") {
                    UsefulMethods()
                        .showToast("Please enter a valid email id");
                  }
                  else {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                        email: _emailEntered.text);
                    UsefulMethods().showToast(
                        "Check your email for password reset steps");
                  }

                  setState(() {
                    _showSpinner = false;
                  });
                },
                child: Container(
                  width: width / 1.3,
                  height: 60,
                  child: Center(
                      child: Text('SUBMIT',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18))),
                  decoration: BoxDecoration(
                      color: HexColor("04D337"),
                      borderRadius: BorderRadius.circular(width)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
