import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'hexcolor.dart';

class UsefulMethods {
  void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 12.0);
  }
}

inputTextField(String hintText, double height, int maxLines, var keyboardType,
    var controller, bool isPassword) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Container(
      height: height,
      child: TextField(
        obscureText: isPassword,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("04D337"), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 1.5),
            ),
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
            hintText: hintText,
            fillColor: Colors.white),
      ),
    ),
  );
}
