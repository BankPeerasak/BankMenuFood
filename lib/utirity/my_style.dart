import 'package:flutter/material.dart';

class MyStyle {
  Widget showProgress() => Center(child: CircularProgressIndicator());

  TextStyle titleStyeH1() => TextStyle(
        fontSize: 20,
        color: Colors.blue.shade700,
        fontWeight: FontWeight.bold,
      );
  TextStyle titleStyeH2() => TextStyle(
        fontSize: 16,
        color: Colors.purple.shade700,
        fontWeight: FontWeight.w500,
      );

  MyStyle();
}
