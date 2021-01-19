import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/screens/app_home_screen.dart';
import 'package:service_app/register_and_login/forgot_password.dart';
import 'package:service_app/register_and_login/register_screen.dart';
import 'package:service_app/utility/useful_methods.dart';

import '../utility/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailEntered = TextEditingController();
  TextEditingController _passwordEntered = TextEditingController();
  bool _hidePassword = true;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset("assets/images/laptopMachine.jpg"),
              SizedBox(height: 40),
              inputTextField("Email", 80, 1, TextInputType.emailAddress,
                  _emailEntered, false),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: TextField(
                  obscureText: _hidePassword,
                  maxLines: 1,
                  controller: _passwordEntered,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: Icon(
                            _hidePassword ? Icons.lock : Icons.remove_red_eye,
                            color: HexColor("04D337")),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor("04D337"), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300], width: 1.5)),
                      contentPadding: EdgeInsets.all(20),
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 12),
                      hintText: "Password",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(height: 25),
              _showSpinner == true
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          _showSpinner = true;
                        });
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailEntered.text,
                                  password: _passwordEntered.text);

                          if (FirebaseAuth.instance.currentUser.emailVerified) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AppHomeScreen()));
                          } else {
                            FirebaseAuth.instance.currentUser
                                .sendEmailVerification();
                            UsefulMethods().showToast(
                                "Please verify your email account by the email sent");
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e);

                          UsefulMethods()
                              .showToast("Please enter correct credentials");
                        }
                        setState(() {
                          _showSpinner = false;
                        });
                      },
                      child: Container(
                        width: width / 1.6,
                        height: 60,
                        child: Center(
                            child: Text('LOG IN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))),
                        decoration: BoxDecoration(
                            color: HexColor("04D337"),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
              SizedBox(height: 40),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ForgotPasswordScreen())),
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(fontSize: 12)),
                  SizedBox(width: 15),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen())),
                      child: Text('Register',
                          style: TextStyle(
                              color: HexColor("04D337"), fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
