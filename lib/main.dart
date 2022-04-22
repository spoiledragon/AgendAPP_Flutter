// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:agendapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Email and Password Login',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: LoginScreen(),
    );
  }
}




