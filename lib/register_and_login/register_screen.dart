import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/register_and_login/login_screen.dart';
import 'package:service_app/utility/useful_methods.dart';

import '../utility/hexcolor.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _hidePassword = true;
  var _hideRePassword = true;
  bool _agreedTerms = false;
  bool _showSpinner = false;

  TextEditingController _usernameEntered = TextEditingController();
  TextEditingController _emailEntered = TextEditingController();
  TextEditingController _passwordEntered = TextEditingController();
  TextEditingController _rePasswordEntered = TextEditingController();

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
              inputTextField('Full Name', 80, 1, TextInputType.name,
                  _usernameEntered, false),
              inputTextField('Email Id', 80, 1, TextInputType.emailAddress,
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
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: TextField(
                  obscureText: _hideRePassword,
                  maxLines: 1,
                  controller: _rePasswordEntered,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hideRePassword = !_hideRePassword;
                          });
                        },
                        icon: Icon(
                          _hideRePassword ? Icons.lock : Icons.remove_red_eye,
                          color: HexColor("04D337"),
                        ),
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
                      hintText: "Re-enter password",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      activeColor: HexColor("04D337"),
                      value: _agreedTerms,
                      onChanged: (bool value) => {
                            setState(() {
                              this._agreedTerms = value;
                            })
                          }),
                  Text('By clicking, you have agreed with our')
                ],
              ),
              SizedBox(height: 10),
              Text('Terms & Conditions',
                  style: TextStyle(color: HexColor("04D337"))),
              SizedBox(height: 30),
              _showSpinner == true
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        if (_passwordEntered.text != _rePasswordEntered.text) {
                          UsefulMethods()
                              .showToast('Re-entered password is not correct');
                        } else {
                          if (_agreedTerms == false) {
                            UsefulMethods().showToast(
                                'Agree Terms & Conditions for registration');
                          } else {
                            if (_usernameEntered.text == null ||
                                _usernameEntered.text == "" ||
                                _emailEntered.text == null ||
                                _emailEntered.text == "" ||
                                _passwordEntered.text == null ||
                                _passwordEntered.text == "" ||
                                _rePasswordEntered.text == "" ||
                                _rePasswordEntered.text == null) {
                              UsefulMethods()
                                  .showToast('Please enter full credentials');
                            } else {
                              setState(() {
                                _showSpinner = true;
                              });

                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailEntered.text,
                                        password: _passwordEntered.text);
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(_emailEntered.text)
                                    .set({
                                  "email": _emailEntered.text,
                                  "name": _usernameEntered.text,
                                  "password": _passwordEntered.text,
                                });

                                UsefulMethods()
                                    .showToast('Registered Successfully');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginScreen()));
                              } catch (e) {
                                UsefulMethods().showToast('$e');
                              }
                              setState(() {
                                _showSpinner = false;
                              });
                            }
                          }
                        }
                      },
                      child: Container(
                        width: width / 1.6,
                        height: 60,
                        child: Center(
                            child: Text('Register',
                                style: TextStyle(color: Colors.white))),
                        decoration: BoxDecoration(
                            color: HexColor("04D337"),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  SizedBox(width: 15),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginScreen())),
                      child: Text('LOG IN',
                          style: TextStyle(color: HexColor("04D337")))),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
