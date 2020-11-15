import 'package:blocCredApp/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(cursorColor: Colors.black, primaryColor: Colors.black),
      home: new HomePage(),
    );
  }
}
