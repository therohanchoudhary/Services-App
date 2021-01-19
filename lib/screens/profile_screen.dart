import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/register_and_login/welcome_screen.dart';
import 'package:service_app/utility/hexcolor.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameEntered = TextEditingController();
  TextEditingController mobileNumberEntered = TextEditingController();
  TextEditingController addressEntered = TextEditingController();
  TextEditingController cityEntered = TextEditingController();
  TextEditingController countryEntered = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    _textFormFields(String labelText, var controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: '$labelText',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[800]),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green[400], width: 2.0)),
            )),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: height / 4,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text('Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: HexColor("04D337"),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(70))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height / 6),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Center(
                        child: Image.asset('assets/images/user.png',
                            height: 100, width: 100, color: Colors.green[800])),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: HexColor("04D337"),
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    width: 120,
                    child: Center(
                        child: Text('Change',
                            style: TextStyle(color: Colors.white)))),
                SizedBox(height: 38),
                Text('Personal Information',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _textFormFields('Full Name', nameEntered),
                _textFormFields('Mobile Number', mobileNumberEntered),
                SizedBox(height: 38),
                Text('Set Address',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _textFormFields('Address', addressEntered),
                _textFormFields('City', cityEntered),
                _textFormFields('Country', countryEntered),
                SizedBox(height: 20),
                Text('Change Password',
                    style: TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.underline)),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                WelcomeScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      color: HexColor("04D337"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:
                          Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
